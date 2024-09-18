import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/enum/enum.dart';

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
      // decoration: const BoxDecoration(color: Colors.blue),
      child: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //need pa mag make og function na mo get sa document aning user nga naa aning Unique Id ron ma access mga info sa user
                Text("Hi, ${AuthController.I.currentUser?.email}"),

                const SizedBox(
                  width: 260,
                  child: Text(
                    "How may I help you today?",
                    style: TextStyle(
                      color: const Color(0xff37B1B8),
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
                        Container(
                          height: 254,
                          width: 190,
                          decoration: BoxDecoration(
                              color: const Color(0xffd8b689),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 70, left: 90),
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
                        //saved and query image button
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
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
          const Text(
            "Chats",
            style: TextStyle(fontSize: 20),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              width: 75,
              height: 35,
              decoration: const BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide(style: BorderStyle.solid, width: 1),
                      horizontal:
                          BorderSide(style: BorderStyle.solid, width: 1)),
                  color: Colors.white),
              child: const Center(child: Text("All")),
            ),
            Container(
              width: 75,
              height: 35,
              decoration: const BoxDecoration(color: Colors.blue),
              child: const Center(
                  child: Text(
                "Recent",
                style: TextStyle(color: Colors.white),
              )),
            ),
            Image.asset("assets/images/search_icon.png")
          ]),
        ],
      ),
    );
  }
}
