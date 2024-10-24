// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/controllers/user_interface_controller.dart';
import 'package:rxseek_v1/src/models/thread_model.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/home/chat_screen.dart';
import 'package:rxseek_v1/src/screens/save_threads/save_thread.dart';
import 'package:rxseek_v1/src/widgets/thread_tile.dart';

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
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData && snapshot.data != null) {
                        return Text(
                            "Hi, ${snapshot.data!["firstName"]} ${snapshot.data!["lastName"]}");
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
                    ),
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
                            GlobalRouter.I.router.go(
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
                                  child: Image.asset(
                                      "assets/images/chat_with_rxseek_button.png"),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Chat with\n RxSeek",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w300),
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
                                    .go(SaveThreadScreen.route);
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
                                        height: 34,
                                        width: 34,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/save_chats_button_icon.png"),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    const Text(
                                      "Saved\n Chats",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
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
                                    child: Image.asset(
                                        "assets/images/chat_with_image_icon.png"),
                                  ),
                                  const Text("Query With\n Image",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13))
                                ],
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
              height: 670,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 285),
                    child: Text(
                      "Chats",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Consumer<UserInterfaceController>(
                      builder: (context, button, child) {
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
                                    ? BoxDecoration(
                                        border: const Border.symmetric(
                                            vertical: BorderSide(
                                                style: BorderStyle.solid,
                                                width: 1),
                                            horizontal: BorderSide(
                                                style: BorderStyle.solid,
                                                width: 1)),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      )
                                    : BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                child: Center(
                                    child: Text("All",
                                        style: button.recent
                                            ? const TextStyle(
                                                color: Colors.black)
                                            : const TextStyle(
                                                color: Colors.white))),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50.0),
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
                                      ? BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        )
                                      : BoxDecoration(
                                          border: const Border.symmetric(
                                              vertical: BorderSide(
                                                  style: BorderStyle.solid,
                                                  width: 1),
                                              horizontal: BorderSide(
                                                  style: BorderStyle.solid,
                                                  width: 1)),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
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
                  Container(
                      color: Colors.white,
                      height: 580,
                      child: StreamBuilder(
                          stream: MessageController.I.getUserThreads(
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
                                  child: Text('No messages found'));
                            }

                            List<Thread>? threads =
                                snapshot.data!.docs.map((doc) {
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
            ),
          ),
        ],
      ),
    );
  }
}
