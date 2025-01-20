import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/image_controller.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/models/message_model.dart';
import 'package:rxseek_v1/src/widgets/message_tile.dart';
import 'package:http/http.dart' as http;
import 'package:rxseek_v1/src/widgets/typing_ani.dart';

class ChatScreen extends StatefulWidget {
  static const String route = "/ChatScreen";
  static const String name = "Chat Screen";
  final String threadId;
  const ChatScreen({required this.threadId, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController messageController;
  final ScrollController scrollController = ScrollController();
  final ImagePicker imagePicker = ImagePicker();
  bool isWaitingForResponse = false;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: size.width * 0.99,
              decoration: const BoxDecoration(color: Colors.white),
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    MessageController.I.getMessagesInThread(widget.threadId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No messages found'));
                  }

                  var messages = snapshot.data!.docs.map((doc) {
                    return Message.fromJson(doc.data() as Map<String, dynamic>);
                  }).toList();

                  if (messages.isNotEmpty && messages.length == 2) {
                    MessageController.I
                        .updateThreadName(widget.threadId, messages);
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: messages.length,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            // Future.delayed(const Duration(seconds: 2), () {
                            //   scrollController.animateTo(
                            //     scrollController.position.maxScrollExtent,
                            //     duration: const Duration(seconds: 1),
                            //     curve: Curves.easeOut,
                            //   );
                            // });
                            return MessageWidget(message: message);
                          },
                        ),
                      ),
                      if (isWaitingForResponse)
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                TypingIndicator(),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 218, 218),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                hintText: "How can I help?",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Image.asset("assets/images/send_button.png"),
                          onPressed: () async {
                            if (messageController.text.isNotEmpty) {
                              setState(() {
                                isWaitingForResponse = true;
                              });

                              var message = Message(
                                messageId:
                                    DateTime.now().millisecondsSinceEpoch,
                                sender: "user",
                                content: messageController.text,
                                imageUrl: "",
                                timeCreated: Timestamp.now(),
                              );

                              MessageController.I
                                  .sendMessage(message, widget.threadId);
                              messageController.clear();

                              try {
                                await MessageController.I.getMessageReponse(
                                    message, widget.threadId);
                              } finally {
                                setState(() {
                                  isWaitingForResponse = false;
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Image.asset("assets/images/upload_image_button.png"),
                  onPressed: () async {
                    setState(() {
                      isWaitingForResponse = true;
                    });

                    try {
                      var listOfImageResults =
                          await ImageController.I.selectandSendImage();
                      String uploadedImageUrl = listOfImageResults[0];

                      var message = Message(
                        messageId: DateTime.now().millisecondsSinceEpoch,
                        sender: "user",
                        content: messageController.text,
                        imageUrl: uploadedImageUrl,
                        timeCreated: Timestamp.now(),
                      );

                      MessageController.I.sendMessage(message, widget.threadId);

                      if (listOfImageResults[1] != null) {
                        await ImageController.I.getOcrResponse(
                            listOfImageResults[1], widget.threadId);
                      }
                    } finally {
                      setState(() {
                        isWaitingForResponse = false;
                      });
                    }
                  },
                ),
                IconButton(
                  icon: Image.asset("assets/images/camera_button.png"),
                  onPressed: () async {
                    setState(() {
                      isWaitingForResponse = true;
                    });

                    try {
                      var listOfImageResults =
                          await ImageController.I.openCameraAndUploadImage();
                      String uploadedImageUrl = listOfImageResults[0];

                      var message = Message(
                        messageId: DateTime.now().millisecondsSinceEpoch,
                        sender: "user",
                        content: messageController.text,
                        imageUrl: uploadedImageUrl,
                        timeCreated: Timestamp.now(),
                      );

                      MessageController.I.sendMessage(message, widget.threadId);

                      if (listOfImageResults[1] != null) {
                        await ImageController.I.getOcrResponse(
                            listOfImageResults[1], widget.threadId);
                      }
                    } finally {
                      setState(() {
                        isWaitingForResponse = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
