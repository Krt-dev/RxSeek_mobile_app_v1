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
        return const Column(
          children: [
            ExpansionPanelList(
                //reminder, tun i ni nga widget para sa mga menus
                )
          ],
        );
      },
    ));
  }
}
