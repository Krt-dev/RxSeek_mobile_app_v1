import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/controllers/user_interface_controller.dart';
import 'package:rxseek_v1/src/models/thread_model.dart';
import 'package:rxseek_v1/src/widgets/chat_button_history.dart';
import 'package:rxseek_v1/src/widgets/thread_tile.dart';

class SaveThreadScreen extends StatefulWidget {
  static const String route = "/saveScreen";
  static const String name = "SaveScreen";
  const SaveThreadScreen({super.key});

  @override
  State<SaveThreadScreen> createState() => _SaveThreadScreenState();
}

class _SaveThreadScreenState extends State<SaveThreadScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const Text(
            "Saved Chats\n",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          const ChatButtonHistory(),
          Center(
            child: SizedBox(
                height: 500,
                width: 350,
                child: Consumer<UserInterfaceController>(
                    builder: (context, button, child) {
                  return StreamBuilder(
                      stream: button.recent
                          ? MessageController.I.getSavedThreadsAll(
                              AuthController.I.currentUser!.uid)
                          : MessageController.I.getSavedThreadsRecent(
                              AuthController.I.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No messages found'));
                        }

                        List<Thread>? threads = snapshot.data!.docs.map((doc) {
                          return Thread.fromJson(
                              doc.data() as Map<String, dynamic>);
                        }).toList();
                        //reversing the list

                        return Consumer<UserInterfaceController>(
                          builder: (context, button, child) {
                            return ThreadTile(
                              threads: threads,
                              recent: button.recent,
                              saveScreen: true,
                            );
                          },
                        );
                      });
                })),
          )
        ],
      ),
    );
  }
}
