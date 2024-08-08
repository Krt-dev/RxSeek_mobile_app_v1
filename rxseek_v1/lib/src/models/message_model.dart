import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final int messageId;
  final String content;
  final int senderId;
  final Timestamp timeCreated;

  Message(
      {required this.messageId,
      required this.content,
      required this.senderId,
      required this.timeCreated});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        messageId: json["messageId"],
        content: json["content"],
        senderId: json["senderId"],
        timeCreated: json["timeCreated"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "messageId": messageId,
      "content": content,
      "senderId": senderId,
      "timeCreated": timeCreated
    };
  }
}
