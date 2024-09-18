import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = "/profile";
  static const String name = "Profile Screen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController scrollController = ScrollController();
  PanelController panelController = PanelController();
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SlidingUpPanel(
      controller: panelController,
      minHeight: 360,
      maxHeight: 360,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35), topRight: Radius.circular(35)),
      body: Scaffold(
          backgroundColor: const Color(0xffd8b689),

          //kaning body mao ni ang backgroiund sa panel
          body: Column(
            children: [
              Center(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Profile",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 107,
                    width: 101,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/sampleProfile.png"),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(
                    width: 172,
                    child: Text("${AuthController.I.currentUser?.email}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 36)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("${AuthController.I.currentUser?.email}",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ))
            ],
          )),
      //mao ni ang panel para marking or dmalibog
      panelBuilder: () {
        return ListView(
          controller: scrollController,
          children: [
            ExpansionTile(
              leading: const Icon(
                Icons.bookmark_outline,
                color: Colors.blue,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(width: 0, color: Colors.transparent),
              ),
              title: const Text("Saved Chats"),
              children: const [
                ListTile(
                  title: Text("Samples rani"),
                ),
                ListTile(
                  title: Text("Samples rani"),
                ),
                ListTile(
                  title: Text("Samples rani"),
                )
              ],
            ),
            ExpansionTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(width: 0, color: Colors.transparent),
              ),
              title: const Text("Settings"),
              children: const [
                ListTile(
                  title: Text("Samples rani"),
                ),
                ListTile(
                  title: Text("Samples rani"),
                ),
                ListTile(
                  title: Text("Samples rani"),
                )
              ],
            ),
            ExpansionTile(
              leading: const Icon(
                Icons.info_outline,
                color: Colors.blue,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(width: 0, color: Colors.transparent),
              ),
              title: const Text("FAQs"),
              children: const [
                ListTile(
                  title: Text("Samples rani"),
                ),
                ListTile(
                  title: Text("Samples rani"),
                ),
                ListTile(
                  title: Text("Samples rani"),
                )
              ],
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Log Out",
              ),
              textColor: Colors.red,
              onTap: () {
                AuthController.I.logout();
              },
            )
          ],
        );
      },
    ));
  }
}
