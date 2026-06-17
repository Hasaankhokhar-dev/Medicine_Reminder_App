import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../models/dose_log_model.dart';
import '../models/medicine_model.dart';
import '../services/medicine_service.dart';

class MedicineController extends GetxController {
  final _service = MedicineService();
  final _auth    = FirebaseAuth.instance;
  String get _uid => _auth.currentUser?.uid ?? '';

  // ── Observables
  final medicines  = <MedicineModel>[].obs;
  final todayLogs  = <DoseLogModel>[].obs;
  final streak     = 0.obs;
  final isLoading  = false.obs;

  // ── Form fields
  final nameCtrl      = TextEditingController();
  final dosageCtrl    = TextEditingController();
  final notesCtrl     = TextEditingController();
  final selectedType  = MedicineType.tablet.obs;
  final selectedTimes = <String>[].obs;
  final selectedDays  = <int>[].obs;
  final isSaving      = false.obs;

  // ── Computed stats
  int get takenCount   => todayLogs.where((l) => l.status == MedicineStatus.taken).length;
  int get pendingCount => todayLogs.where((l) => l.status == MedicineStatus.pending).length;
  int get missedCount  => todayLogs.where((l) => l.status == MedicineStatus.missed).length;
  int get totalCount   => todayLogs.length;

  // ── Next pending dose
  DoseLogModel? get nextDose {
    final pending = todayLogs
        .where((l) => l.status == MedicineStatus.pending)
        .toList()
      ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
    return pending.isEmpty ? null : pending.first;
  }

  @override
  void onInit() {
    super.onInit();
    // ✅ Auth state ready hone ka wait karo — restart pe bhi kaam karega
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _init();
      } else {
        // User logout ho gaya — data clear karo
        medicines.clear();
        todayLogs.clear();
        streak.value = 0;
      }
    });
  }

  Future<void> _init() async {
    if (_uid.isEmpty) return;
    isLoading.value = true;

    try {
      // ✅ Medicines listen — generate karo phir logs fetch karo
      _service.fetchMedicines(_uid).listen((list) async {
        medicines.value = list;

        // Aaj ke logs generate karo
        await _service.generateTodayLogs(_uid, list);

        // ✅ Generate ke baad fresh logs fetch karo — fetchTodayLogs
        _service.fetchTodayLogs(_uid, DateTime.now()).listen(
              (logs) {
            todayLogs.value = logs
              ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
            if (isLoading.value) isLoading.value = false;
          },
          onError: (e) {
            print('❌ fetchTodayLogs error: $e');
            isLoading.value = false;
          },
        );
      }, onError: (e) {
        print('❌ fetchMedicines error: $e');
        isLoading.value = false;
      });

      // Streak background mein fetch karo
      _service.fetchStreak(_uid).then((v) => streak.value = v);

      // 5 second baad force stop loading
      Future.delayed(const Duration(seconds: 5), () {
        if (isLoading.value) isLoading.value = false;
      });

    } catch (e) {
      print('❌ _init error: $e');
      isLoading.value = false;
    }
  }

  // ── Mark dose taken
  Future<void> markTaken(String logId) async {
    await _service.updateDoseStatus(_uid, logId, MedicineStatus.taken);
    streak.value = await _service.fetchStreak(_uid);
  }

  // ── Snooze
  void snooze(String logId) {
    Get.snackbar(
      'Snoozed',
      'Reminder set for 15 minutes later',
      backgroundColor: AppColors.primary,
      colorText: AppColors.white,
    );
  }

  // ── Delete medicine
  Future<void> deleteMedicine(String medicineId) async {
    await _service.deleteMedicine(_uid, medicineId);
    Get.back();
    Get.snackbar(
      'Deleted',
      'Medicine removed successfully',
      backgroundColor: AppColors.error,
      colorText: AppColors.white,
    );
  }

  // ── Form helpers
  void selectType(MedicineType type) => selectedType.value = type;

  void toggleTime(String time) {
    selectedTimes.contains(time)
        ? selectedTimes.remove(time)
        : selectedTimes.add(time);
  }

  void toggleDay(int day) {
    selectedDays.contains(day)
        ? selectedDays.remove(day)
        : selectedDays.add(day);
  }

  void resetForm() {
    nameCtrl.clear();
    dosageCtrl.clear();
    notesCtrl.clear();
    selectedType.value = MedicineType.tablet;
    selectedTimes.clear();
    selectedDays.clear();
  }

  // ── Save medicine
  Future<void> saveMedicine() async {
    if (_uid.isEmpty) {
      Get.snackbar('Error', 'User not found. Please login again.',
          backgroundColor: AppColors.error, colorText: AppColors.white);
      return;
    }

    if (nameCtrl.text.trim().isEmpty ||
        dosageCtrl.text.trim().isEmpty ||
        selectedTimes.isEmpty ||
        selectedDays.isEmpty) {
      Get.snackbar('Error', 'Please fill all required fields',
          backgroundColor: AppColors.error, colorText: AppColors.white);
      return;
    }

    try {
      isSaving.value = true;

      final medicine = MedicineModel(
        id           : DateTime.now().millisecondsSinceEpoch.toString(),
        userId       : _uid,
        name         : nameCtrl.text.trim(),
        dosage       : dosageCtrl.text.trim(),
        type         : selectedType.value,
        reminderTimes: List<String>.from(selectedTimes),
        repeatDays   : List<int>.from(selectedDays),
        notes        : notesCtrl.text.trim().isEmpty ? null : notesCtrl.text.trim(),
        createdAt    : DateTime.now(),
      );

      // 1. Firestore mein save karo
      await _service.addMedicine(medicine);

      // 2. ✅ Aaj ke logs generate karo — HomeView mein foran show hoga
      await _service.generateTodayLogs(_uid, [medicine]);

      resetForm();

      Get.snackbar(
        'Success',
        'Medicine added successfully!',
        backgroundColor: AppColors.primary,
        colorText: AppColors.white,
      );

    } catch (e) {
      Get.snackbar('Error', 'Failed: $e',
          backgroundColor: AppColors.error, colorText: AppColors.white);
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    dosageCtrl.dispose();
    notesCtrl.dispose();
    super.onClose();
  }
}