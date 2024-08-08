import 'package:cloud_firestore/cloud_firestore.dart';

class Thread {
  final String threadId;
  final String threadName;
  final bool save;
  final String userId;
  final Timestamp timeCreated;

  Thread(
      {required this.threadId,
      required this.threadName,
      required this.save,
      required this.userId,
      required this.timeCreated});

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
        threadId: json["threadId"],
        threadName: json["threadName"],
        save: json["save"],
        userId: json["userId"],
        timeCreated: json["timeCreated"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "threadId": threadId,
      "threadName": threadName,
      "save": save,
      "userId": userId,
      "timeCreated": timeCreated
    };
  }
}
