import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class ProfileScreen extends StatelessWidget {
  static const String route = "/profile";
  static const String name = "Profile Screen";
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SlidingUpPanel(
      minHeight: 345,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35), topRight: Radius.circular(35)),
      body: const Scaffold(
          backgroundColor: Color.fromARGB(255, 197, 139, 118),
          body: Column(
            children: [
              Center(
                  child: Column(
                children: [Icon(Icons.image), Text("Sample Name")],
              ))
            ],
          )),
      panelBuilder: () {
        return Column(
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
              leading: const Icon(Icons.settings),
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
            )
          ],
        );
      },
    ));
  }
}
