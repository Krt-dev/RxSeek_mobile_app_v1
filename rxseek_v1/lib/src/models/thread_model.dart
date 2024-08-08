import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxseek_v1/src/enum/enum.dart';

class Thread {
  final int threadId;
  final String threadName;
  final Save save;
  final int userId;
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
