import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/dialogs/waiting_dialog.dart';
import 'package:rxseek_v1/src/models/message_model.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/profile/profile_screen.dart';
import 'package:rxseek_v1/src/widgets/message_tile.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";
  static const String name = "Home Screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                stream: MessageController.I.getMessages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No messages found'));
                  }
                  var messages = snapshot.data!.docs.map((doc) {
                    return Message.fromJson(doc.data() as Map<String, dynamic>);
                  }).toList();

                  return ListView.builder(
                    itemCount: messages.length,
                    controller: scrollController,
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
                              timeCreated: Timestamp.now(),
                            );
                            MessageController.I.sendMessage(message);
                            scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut);
                            MessageController.I.getMessageReponse(message);
                            Future.delayed(const Duration(seconds: 8), () {
                              scrollController.animateTo(
                                  scrollController.position.maxScrollExtent,
                                  duration: const Duration(seconds: 3),
                                  curve: Curves.easeOut);
                            });
                            messageController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Image.asset("assets/images/camera_button.png"),
                  onPressed: () {
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
}
