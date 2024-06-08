import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? username;
  final String? email;
  final String? mobile;
  final String? id;
  final String? gender;

  UserModel({this.id, this.username, this.email, this.mobile, this.gender});

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      username: snapshot['username'],
      mobile: snapshot['mobile'],
      email: snapshot['email'],
      gender: snapshot['gender'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "id": id,
      "mobile": mobile,
      "gender": gender,
    };
  }
}
