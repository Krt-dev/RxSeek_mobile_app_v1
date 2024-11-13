import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/image_controller.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/models/message_model.dart';
import 'package:rxseek_v1/src/widgets/message_tile.dart';

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
      child:
          // appBar: AppBar(
          //   leading: InkWell(
          //     onTap: () {
          //       //for testing rani para maka route padung profile page
          //       GlobalRouter.I.router.go(ProfileScreen.route);
          //     },
          //     child: Image.asset("assets/images/burger_button.png"),
          //   ),
          //   actions: [
          //     InkWell(
          //       onTap: () {
          //         WaitingDialog.show(context, future: AuthController.I.logout());
          //       },
          //       child: const Icon(
          //         Icons.more_vert,
          //         size: 50,
          //       ),
          //     ),
          //   ],
          //   title: Image.asset("assets/images/RxSeek_name.png"),
          // ),
          Column(
        children: [
          //this part is sa messages
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

                  if (messages.isNotEmpty && messages.length == 1) {
                    MessageController.I
                        .updateThreadName(widget.threadId, messages);
                  }

                  return ListView.builder(
                    itemCount: messages.length,
                    // controller: scrollController,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      // Future.delayed(const Duration(seconds: 2), () {
                      //   scrollController.animateTo(
                      //       scrollController.position.maxScrollExtent,
                      //       duration: const Duration(seconds: 1),
                      //       curve: Curves.easeOut);
                      // });
                      return MessageWidget(message: message);
                    },
                  );
                },
              ),
            ),
          ),
          //this part is sa textfield
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
                          onPressed: () {
                            var message = Message(
                              messageId: DateTime.now().millisecondsSinceEpoch,
                              sender: "user",
                              content: messageController.text,
                              imageUrl: "",
                              timeCreated: Timestamp.now(),
                            );
                            MessageController.I
                                .sendMessage(message, widget.threadId);
                            // scrollController.animateTo(
                            //     scrollController.position.maxScrollExtent,
                            //     duration: const Duration(milliseconds: 300),
                            //     curve: Curves.easeOut);
                            messageController.clear();
                            MessageController.I
                                .getMessageReponse(message, widget.threadId);
                            // Future.delayed(const Duration(seconds: 8), () {
                            //   scrollController.animateTo(
                            //       scrollController.position.maxScrollExtent,
                            //       duration: const Duration(seconds: 3),
                            //       curve: Curves.easeOut);
                            // });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Image.asset("assets/images/upload_image_button.png"),
                  onPressed: () async {
                    String uploadedImageUrl = await sendImage();
                    var message = Message(
                      messageId: DateTime.now().millisecondsSinceEpoch,
                      sender: "user",
                      content: messageController.text,
                      imageUrl: uploadedImageUrl,
                      timeCreated: Timestamp.now(),
                    );
                    MessageController.I.sendMessage(message, widget.threadId);

                    // Handle camera button press
                  },
                ),
                IconButton(
                  icon: Image.asset("assets/images/camera_button.png"),
                  onPressed: () async {
                    String uploadedImageUrl = await openCameraAndUploadImage();
                    var message = Message(
                      messageId: DateTime.now().millisecondsSinceEpoch,
                      sender: "user",
                      content: messageController.text,
                      imageUrl: uploadedImageUrl,
                      timeCreated: Timestamp.now(),
                    );
                    MessageController.I.sendMessage(message, widget.threadId);

                    // Handle camera button press
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> sendImage() async {
    Uint8List img = await ImageController.I.selectImage();
    String userId = AuthController.I.currentUser!.uid;
    String imageNetworkUrl = await ImageController.I.uploadImageToDb(
        img, "${userId}/${Timestamp.now().millisecondsSinceEpoch}");
    return imageNetworkUrl;
  }

  Future<String> openCameraAndUploadImage() async {
    Uint8List img = await ImageController.I.captureImage();
    String userId = AuthController.I.currentUser!.uid;
    String imageNetworkUrl = await ImageController.I.uploadImageToDb(
        img, "${userId}/${Timestamp.now().millisecondsSinceEpoch}");
    return imageNetworkUrl;
  }
}
