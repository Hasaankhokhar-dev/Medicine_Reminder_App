import 'package:cloud_firestore/cloud_firestore.dart';

import 'medicine_model.dart';

class DoseLogModel {
  final String id;
  final String medicineId;
  final String userId;
  final String medicineName;
  final String dosage;
  final MedicineType type;
  final String scheduledTime;
  final DateTime scheduledDate;
   MedicineStatus status;

   DoseLogModel({
    required this.id,
    required this.medicineId,
    required this.userId,
    required this.medicineName,
    required this.dosage,
    required this.type,
    required this.scheduledTime,
    required this.scheduledDate,
    required this.status,
});
   Map<String, dynamic> toMap(){
     return{
       'id': id,
       'medicineId': medicineId,
       'userId': userId,
       'medicineName': medicineName,
       'dosage': dosage,
       'type': type.name,
       'scheduledTime': scheduledTime,
       'scheduledDate': Timestamp.fromDate(scheduledDate),
       'status': status.name,
     };
   }
  factory DoseLogModel.fromMap(Map<String, dynamic> map) {
    return DoseLogModel(
      id: map['id'] ?? '',
      medicineId: map['medicineId'] ?? '',
      userId: map['userId'] ?? '',
      medicineName: map['medicineName'] ?? '',
      dosage: map['dosage'] ?? '',
      type: MedicineType.values.firstWhere(
            (e) => e.name == map['type'],
        orElse: () => MedicineType.tablet,
      ),
      scheduledTime: map['scheduledTime'] ?? '',
      scheduledDate: (map['scheduledDate'] as Timestamp).toDate(),
      status: MedicineStatus.values.firstWhere(
            (e) => e.name == map['status'],
        orElse: () => MedicineStatus.pending,
      ),
    );
  }
}