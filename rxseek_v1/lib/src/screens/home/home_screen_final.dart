// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/image_controller.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/controllers/user_interface_controller.dart';
import 'package:rxseek_v1/src/models/message_model.dart';
import 'package:rxseek_v1/src/models/thread_model.dart';
import 'package:rxseek_v1/src/models/user_model.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/home/chat_screen.dart';
import 'package:rxseek_v1/src/screens/save_threads/save_thread.dart';
import 'package:rxseek_v1/src/widgets/chat_button_history.dart';
import 'package:rxseek_v1/src/widgets/thread_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreenFinal extends StatefulWidget {
  static const String route = "/homeScreenFinal";
  static const String name = "Home Screen Final";
  const HomeScreenFinal({super.key});

  @override
  State<HomeScreenFinal> createState() => _HomeScreenFinalState();
}

class _HomeScreenFinalState extends State<HomeScreenFinal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: AuthController.I
                        .getUser(AuthController.I.currentUser!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "Hi, Guess",
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w500),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData && snapshot.data != null) {
                        return Text(
                          "Hi, ${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                          style: const TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w500),
                        );
                      } else {
                        return const Center(child: Text('No User is found'));
                      }
                    }),

                const SizedBox(
                  width: 260,
                  child: Text(
                    "How may I help you today?",
                    style: TextStyle(
                        color: Color(0xff37B1B8),
                        fontSize: 24,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                //buttons
                //rxsekk chat button
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: 330,
                    height: 254,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //chat with rxseek button
                        InkWell(
                          onTap: () async {
                            Thread newThread = Thread(
                                threadId: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                threadName: "",
                                save: false,
                                userId: AuthController.I.currentUser!.uid,
                                timeCreated: Timestamp.now());

                            await MessageController.I
                                .createNewThread(newThread);
                            GlobalRouter.I.router.push(
                                "${ChatScreen.route}/${newThread.threadId}");
                          },
                          child: Container(
                            height: 254,
                            width: 190,
                            decoration: BoxDecoration(
                                color: const Color(0xffd8b689),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 70, left: 90),
                                  child: SvgPicture.asset(
                                    "assets/images/chatWithRxSeek.svg",
                                    width: 44,
                                    height: 44,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Chat with\n RxSeek",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //saved and query image button
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                GlobalRouter.I.router
                                    .push(SaveThreadScreen.route);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: const Color(0xff6796B7),
                                    borderRadius: BorderRadius.circular(20)),
                                height: 120,
                                width: 115,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 60),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          "assets/images/bookmark.svg",
                                          width: 34,
                                          height: 34,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Saved\n Chats",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Thread newThread = Thread(
                                    threadId: DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    threadName: "",
                                    save: false,
                                    userId: AuthController.I.currentUser!.uid,
                                    timeCreated: Timestamp.now());

                                await MessageController.I
                                    .createNewThread(newThread);
                                GlobalRouter.I.router.push(
                                    "${ChatScreen.route}/${newThread.threadId}");

                                var listOfImageResults = await ImageController.I
                                    .selectandSendImage();
                                String uploadedImageUrl = listOfImageResults[0];

                                var message = Message(
                                  messageId:
                                      DateTime.now().millisecondsSinceEpoch,
                                  sender: "user",
                                  content: "",
                                  imageUrl: uploadedImageUrl,
                                  timeCreated: Timestamp.now(),
                                );
                                MessageController.I
                                    .sendMessage(message, newThread.threadId);
                                //diri kay function to send the image to the backend then get and response nya i send sa db then butang sa frontend
                                if (listOfImageResults[1] != null) {
                                  ImageController.I.getOcrResponse(
                                      listOfImageResults[1],
                                      newThread.threadId);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: const Color(0xff37B1B8),
                                    borderRadius: BorderRadius.circular(20)),
                                height: 120,
                                width: 115,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 60),
                                      child: SvgPicture.asset(
                                        "assets/images/image_icon.svg",
                                        width: 34,
                                        height: 34,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const Text("Query With\n Image",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          //History or recents chats patrt from here to down!!!!!!!
          //!!!!!!!!!!!!!!!!!
          //Marker ni or ilhanan !!!!!!!!!!!!!!!

          Center(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 15),
              width: 340,
              height: 720,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 255, bottom: 20),
                    child: Text(
                      "Chats",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const ChatButtonHistory(),
                  Container(
                      color: Colors.white,
                      height: 580,
                      child: Consumer<UserInterfaceController>(
                          builder: (context, button, child) {
                        return StreamBuilder(
                            stream: button.recent
                                ? MessageController.I.getUserThreadsRecent(
                                    AuthController.I.currentUser!.uid)
                                : MessageController.I.getUserThreadsAll(
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
                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Center(
                                    child: Text(
                                  'No messages yet',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w600),
                                ));
                              }

                              List<Thread>? threads =
                                  snapshot.data!.docs.map((doc) {
                                return Thread.fromJson(
                                    doc.data() as Map<String, dynamic>);
                              }).toList();
                              //reversing the list

                              return ThreadTile(
                                threads: threads,
                                recent: button.recent,
                                saveScreen: false,
                              );
                            });
                      }))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
