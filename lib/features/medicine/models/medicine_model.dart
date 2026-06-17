import 'package:cloud_firestore/cloud_firestore.dart';

enum MedicineType { tablet, capsule, syrup, injection }

enum MedicineStatus { taken, pending, missed }

class MedicineModel {
  final String id;
  final String userId;
  final String name;
  final String dosage;
  final MedicineType type;
  final List<String> reminderTimes; // ["08:00", "14:00"]
  final List<int> repeatDays;       // [1,2,3,4,5] — Mon=1, Sun=7
  final String? notes;
  final String? imageUrl;
  final DateTime createdAt;

  MedicineModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.dosage,
    required this.type,
    required this.reminderTimes,
    required this.repeatDays,
    this.notes,
    this.imageUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'dosage': dosage,
      'type': type.name,
      'reminderTimes': reminderTimes,
      'repeatDays': repeatDays,
      'notes': notes,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      dosage: map['dosage'] ?? '',
      type: MedicineType.values.firstWhere(
            (e) => e.name == map['type'],
        orElse: () => MedicineType.tablet,
      ),
      reminderTimes: List<String>.from(map['reminderTimes'] ?? []),
      repeatDays: List<int>.from(map['repeatDays'] ?? []),
      notes: map['notes'],
      imageUrl: map['imageUrl'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}