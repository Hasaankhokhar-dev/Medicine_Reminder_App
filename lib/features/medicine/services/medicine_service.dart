import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/medicine_model.dart';
import '../models/dose_log_model.dart';

class MedicineService {
  final _db = FirebaseFirestore.instance;

  // ── Medicines collection
  CollectionReference _medicinesRef(String userId) =>
      _db.collection('users').doc(userId).collection('medicines');

  // ── Dose logs collection
  CollectionReference _logsRef(String userId) =>
      _db.collection('users').doc(userId).collection('dose_logs');

  // Add medicine
  Future<void> addMedicine(MedicineModel medicine) async {
    // Ensure user document exists for visibility in console
    await _db.collection('users').doc(medicine.userId).set({
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await _medicinesRef(medicine.userId).doc(medicine.id).set(medicine.toMap());
  }

  // Delete medicine
  Future<void> deleteMedicine(String userId, String medicineId) async {
    await _medicinesRef(userId).doc(medicineId).delete();
  }

  // Fetch all medicines (realtime)
  Stream<List<MedicineModel>> fetchMedicines(String userId) {
    return _medicinesRef(userId).snapshots().map((snap) =>
        snap.docs.map((d) => MedicineModel.fromMap(d.data() as Map<String, dynamic>)).toList());
  }

  // Fetch today's dose logs (realtime)
  Stream<List<DoseLogModel>> fetchTodayLogs(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end   = start.add(const Duration(days: 1));
    return _logsRef(userId)
        .where('scheduledDate', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('scheduledDate', isLessThan: Timestamp.fromDate(end))
        .snapshots()
        .map((snap) => snap.docs
        .map((d) => DoseLogModel.fromMap(d.data() as Map<String, dynamic>))
        .toList());
  }

  // Generate today's logs from medicines
  Future<void> generateTodayLogs(String userId, List<MedicineModel> medicines) async {
    final today = DateTime.now();
    final todayWeekday = today.weekday; // Mon=1, Sun=7

    for (final med in medicines) {
      if (!med.repeatDays.contains(todayWeekday)) continue;

      for (final time in med.reminderTimes) {
        final logId = '${med.id}_${today.year}-${today.month}-${today.day}_$time';
        
        // Use a transaction or a simpler check to avoid unnecessary writes
        final docRef = _logsRef(userId).doc(logId);
        final doc = await docRef.get();
        
        if (!doc.exists) {
          final log = DoseLogModel(
            id: logId,
            medicineId: med.id,
            userId: userId,
            medicineName: med.name,
            dosage: med.dosage,
            type: med.type,
            scheduledTime: time,
            scheduledDate: today,
            status: MedicineStatus.pending,
          );
          await docRef.set(log.toMap());
        }
      }
    }
  }

  // Mark dose as taken/missed/snoozed
  Future<void> updateDoseStatus(String userId, String logId, MedicineStatus status) async {
    await _logsRef(userId).doc(logId).update({'status': status.name});
  }

  // Fetch streak — optimized to not loop 365 times unless necessary
  Future<int> fetchStreak(String userId) async {
    int streak = 0;
    DateTime date = DateTime.now();

    // Check last 30 days for now to improve performance
    for (int i = 0; i < 30; i++) {
      final start = DateTime(date.year, date.month, date.day);
      final end   = start.add(const Duration(days: 1));

      final snap = await _logsRef(userId)
          .where('scheduledDate', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
          .where('scheduledDate', isLessThan: Timestamp.fromDate(end))
          .get();

      if (snap.docs.isEmpty) break;

      final logs = snap.docs
          .map((d) => DoseLogModel.fromMap(d.data() as Map<String, dynamic>))
          .toList();

      final allTaken = logs.every((l) => l.status == MedicineStatus.taken);
      if (!allTaken) break;

      streak++;
      date = date.subtract(const Duration(days: 1));
    }

    return streak;
  }
}
