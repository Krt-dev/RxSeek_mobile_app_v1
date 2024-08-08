import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/dialogs/waiting_dialog.dart';
import 'package:rxseek_v1/src/models/message_model.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";
  static const String name = "Home Screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController messageController;

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
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {},
            child: Image.asset("assets/images/burger_button.png"),
          ),
          actions: [
            InkWell(
              onTap: () {
                WaitingDialog.show(context, future: AuthController.I.logout());
              },
              child: const Icon(
                Icons.more_vert,
                size: 50,
              ),
            ),
          ],
          title: Image.asset("assets/images/RxSeek_name.png"),
        ),
        body: Column(
          children: [
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
                      return Message.fromJson(
                          doc.data() as Map<String, dynamic>);
                    }).toList();

                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return ListTile(
                          title: Text(message.content),
                          subtitle: Text(message.sender),
                          trailing: Text(
                            message.timeCreated.toDate().toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      },
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
                            onPressed: () {
                              var message = Message(
                                messageId: DateTime.now()
                                    .millisecondsSinceEpoch, // Auto-generate ID
                                sender: "user",
                                content: messageController.text,
                                timeCreated: Timestamp.now(),
                              );
                              MessageController.I.sendMessage(message);
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
      ),
    );
  }
}
