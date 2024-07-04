import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? username;
  final String? email;
  final String? mobile;
  final String? id;
  final String? gender;
  final String? role;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.mobile,
      this.gender,
      this.role});

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      username: snapshot['username'],
      mobile: snapshot['mobile'],
      email: snapshot['email'],
      gender: snapshot['gender'],
      id: snapshot['id'],
      role: snapshot['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "id": id,
      "mobile": mobile,
      "gender": gender,
      "role": role,
    };
  }
}
