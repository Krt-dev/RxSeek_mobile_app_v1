import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/models/message_model.dart';
import 'package:http/http.dart' as http;
import 'package:rxseek_v1/src/models/thread_model.dart';

class MessageController with ChangeNotifier {
  // Static method to initialize the singleton in GetIt
  static void initialize() {
    GetIt.instance.registerSingleton<MessageController>(MessageController());
  }

  // Static getter to access the instance through GetIt
  static MessageController get instance => GetIt.instance<MessageController>();

  static MessageController get I => GetIt.instance<MessageController>();

  FirebaseFirestore db = FirebaseFirestore.instance;
//send messsage nya butang sa db then butang sa ui
  Future<void> sendMessage(Message message) async {
    try {
      db
          .collection("Thread")
          .doc("sampleThread")
          .collection("Messages")
          .add(message.toJson());
    } on FirebaseException catch (e) {
      print({e.toString()});
    }
  }

  //gekan sa ge send na message agto backend generate response nya i get response nya save sa db nya butang sa ui
  Future<void> getMessageReponse(Message message) async {
    //mao ni atong post request to process the query sa backend then get the response sa LLM gekan sa backend from the query
    final response = await http.post(
      Uri.parse("http://10.0.2.2:8000/process_query/"),

      // Uri.parse("http://127.0.0.1:8000/process_query/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "query": message.content,
      }),
    );

    try {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        Message messageResponse = Message(
            messageId: DateTime.now().millisecondsSinceEpoch,
            content: jsonResponse["response"],
            sender: "system",
            timeCreated: Timestamp.now());
        try {
          db
              .collection("Thread")
              .doc("sampleThread")
              .collection("Messages")
              .add(messageResponse.toJson());
        } on FirebaseException catch (e) {
          print({e.toString()});
        }
        print("succesfful response  ");
      } else {
        // throw Exception('Failed to generate response');
        print('Failed to generate response');
      }
    } catch (e) {
      print({e});
    }
  }

  Stream<QuerySnapshot> getMessagesInThread(String threadId) {
    try {
      return db
          .collection("Thread")
          .doc(threadId)
          .collection("Messages")
          .orderBy("timeCreated", descending: false)
          .snapshots();
    } on FirebaseException catch (e) {
      print({e.toString()});
      return const Stream.empty();
    }
  }

////////threadssssssssssssss
//initial

//buhatanan og index sa firebase pangitae paagi mabuhatan index kay composite ang query or nag use og
//duha ka clause which is nad orederbyog and where so needog index para madungan nig gamit ang duha
  Stream<QuerySnapshot> getUserThreads(String userId) {
    try {
      return db
          .collection("Thread")
          .where("userId", isEqualTo: userId)
          .orderBy("timeCreated", descending: false)
          .snapshots();
    } on FirebaseException catch (e) {
      print({e.toString()});
      rethrow;
    }
  }

  //para create new thread
  //initial
  Future<void> createNewThread(Thread newThread) async {
    try {
      db.collection("Thread").add(newThread.toJson());
    } on FirebaseException catch (e) {
      print({e.toString()});
    }
  }
}
