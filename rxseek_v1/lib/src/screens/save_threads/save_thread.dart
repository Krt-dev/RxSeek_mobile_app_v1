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
    // Get screen size
    final Size screenSize = MediaQuery.of(context).size;

    // Calculate responsive dimensions
    final double height = screenSize.height * 0.69;
    final double width = screenSize.width > 600 ? 500 : screenSize.width * 0.9;

    return Material(
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            const Text(
              "Saved Chats\n",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            const ChatButtonHistory(),
            Center(
              child: SizedBox(
                  height: height,
                  width: width,
                  child: StreamBuilder(
                      stream: MessageController.I
                          .getSavedThreads(AuthController.I.currentUser!.uid),
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
                        List<Thread>? reversedThreads =
                            threads.reversed.toList();

                        return Consumer<UserInterfaceController>(
                          builder: (context, button, child) {
                            return ThreadTile(
                              threads: reversedThreads,
                              recent: button.recent,
                            );
                          },
                        );
                      })),
            )
          ],
        ),
      ),
    );
  }
}
