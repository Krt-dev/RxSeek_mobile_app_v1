import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final int messageId;
  final String content;
  final String sender;
  final String imageUrl;
  final Timestamp timeCreated;

  Message(
      {required this.messageId,
      required this.content,
      required this.sender,
      required this.imageUrl,
      required this.timeCreated});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        messageId: json["messageId"],
        content: json["content"],
        sender: json["senderId"],
        imageUrl: json["imageUrl"],
        timeCreated: json["timeCreated"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "messageId": messageId,
      "content": content,
      "senderId": sender,
      "imageUrl": imageUrl,
      "timeCreated": timeCreated
    };
  }
}
