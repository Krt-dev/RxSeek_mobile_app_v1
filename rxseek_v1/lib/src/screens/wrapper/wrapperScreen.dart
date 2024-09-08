import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/dialogs/waiting_dialog.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/home/home_screen.dart';
import 'package:rxseek_v1/src/screens/home/home_screen_final.dart';
import 'package:rxseek_v1/src/screens/profile/profile_screen.dart';

class HomeWrapper extends StatefulWidget {
  final Widget? child;
  const HomeWrapper({super.key, this.child});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int index = 0;

  List<String> routes = [HomeScreenFinal.route, ProfileScreen.route];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            //for testing rani para maka route padung profile page
            GlobalRouter.I.router.go(ProfileScreen.route);
          },
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
      body: widget.child ?? const Placeholder(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;

            GlobalRouter.I.router.go(routes[i]);
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }
}
