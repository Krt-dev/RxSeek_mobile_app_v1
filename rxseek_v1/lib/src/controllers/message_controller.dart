import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxseek_v1/src/models/message_model.dart';

class MessageController with ChangeNotifier {
  // Static method to initialize the singleton in GetIt
  static void initialize() {
    GetIt.instance.registerSingleton<MessageController>(MessageController());
  }

  // Static getter to access the instance through GetIt
  static MessageController get instance => GetIt.instance<MessageController>();

  static MessageController get I => GetIt.instance<MessageController>();

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> sendMessage(Message message) async {
    try {
      db
          .collection("Thread")
          .doc("sampleThread")
          .collection("Messages")
          .doc("sampleMessage")
          .set(message.toJson());
    } on FirebaseException catch (e) {
      print({e.toString()});
    }
  }
}
