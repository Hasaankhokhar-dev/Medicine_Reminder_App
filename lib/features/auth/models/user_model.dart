import 'package:firebase_auth/firebase_auth.dart';
class UserModel {
  final String uid;
  final String name;
  final String email;

  UserModel({
    required this.uid,
    required this.name,
    required this.email
  });
  factory UserModel.fromFirebase(User user){
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
  }
  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
  factory UserModel.fromMap(Map<String, dynamic> data, String id) {
    return UserModel(
      uid: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }
}