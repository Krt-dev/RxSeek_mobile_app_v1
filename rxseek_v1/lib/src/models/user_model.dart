import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxseek_v1/src/enum/enum.dart';

class UserModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String status;
  final String profileUrl;
  final Timestamp joinedAt;

  UserModel(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email,
      required this.status,
      required this.profileUrl,
      required this.joinedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        email: json["email"],
        status: json["status"],
        profileUrl: json["profileUrl"],
        joinedAt: json["joinedAt"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
      "email": email,
      "status": status,
      "profileUrl": profileUrl,
      "joinedAt": joinedAt
    };
  }
}
