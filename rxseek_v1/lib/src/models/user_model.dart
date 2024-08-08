import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final int userId;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String status;
  final String profileUrl;
  final Timestamp joinedAt;

  User(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email,
      required this.status,
      required this.profileUrl,
      required this.joinedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
