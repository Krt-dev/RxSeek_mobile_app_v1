import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/controllers/user_interface_controller.dart';
import 'package:rxseek_v1/src/models/thread_model.dart';
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
          Consumer<UserInterfaceController>(builder: (context, button, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 70, bottom: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<UserInterfaceController>(context,
                                listen: false)
                            .handleTapAlllButton();
                        print("tapped All");
                      },
                      child: Container(
                        width: 65,
                        height: 30,
                        decoration: button.recent
                            ? const BoxDecoration(
                                border: Border.symmetric(
                                    vertical: BorderSide(
                                        style: BorderStyle.solid, width: 1),
                                    horizontal: BorderSide(
                                        style: BorderStyle.solid, width: 1)),
                                color: Colors.white)
                            : const BoxDecoration(color: Colors.blue),
                        child: Center(
                            child: Text("All",
                                style: button.recent
                                    ? const TextStyle(color: Colors.black)
                                    : const TextStyle(color: Colors.white))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50.0),
                      child: InkWell(
                        onTap: () {
                          Provider.of<UserInterfaceController>(context,
                                  listen: false)
                              .handleTapRecentButton();

                          print("tapped Recent");
                        },
                        child: Container(
                          width: 65,
                          height: 30,
                          decoration: button.recent
                              ? const BoxDecoration(color: Colors.blue)
                              : const BoxDecoration(
                                  border: Border.symmetric(
                                      vertical: BorderSide(
                                          style: BorderStyle.solid, width: 1),
                                      horizontal: BorderSide(
                                          style: BorderStyle.solid, width: 1)),
                                  color: Colors.white),
                          child: Center(
                              child: Text(
                            "Recent",
                            style: button.recent
                                ? const TextStyle(color: Colors.white)
                                : const TextStyle(color: Colors.black),
                          )),
                        ),
                      ),
                    ),
                    Image.asset("assets/images/search_icon.png")
                  ]),
            );
          }),
          SizedBox(
              height: 500,
              child: StreamBuilder(
                  stream: MessageController.I
                      .getSavedThreads(AuthController.I.currentUser!.uid),
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

                    List<Thread>? threads = snapshot.data!.docs.map((doc) {
                      return Thread.fromJson(
                          doc.data() as Map<String, dynamic>);
                    }).toList();

                    return Consumer<UserInterfaceController>(
                      builder: (context, button, child) {
                        return ThreadTile(
                          threads: threads,
                          recent: button.recent,
                        );
                      },
                    );
                  }))
        ],
      ),
    );
  }
}
