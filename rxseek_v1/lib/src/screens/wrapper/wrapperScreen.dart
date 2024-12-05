import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/dialogs/waiting_dialog.dart';
import 'package:rxseek_v1/src/routing/router.dart';
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
        leadingWidth: 50,
        leading: InkWell(
          onTap: () {
            GlobalRouter.I.router.go(HomeScreenFinal.route);
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
      bottomNavigationBar: SizedBox(
        height: 61,
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) {
            setState(() {
              index = i;

              GlobalRouter.I.router.go(routes[i]);
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  height: 26,
                  width: 26,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/messave_nav_icon.png"),
                          fit: BoxFit.cover)),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Container(
                  height: 26,
                  width: 26,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/profile_nav_icon.png"),
                          fit: BoxFit.cover)),
                ),
                label: ""),
          ],
        ),
      ),
    );
  }
}
