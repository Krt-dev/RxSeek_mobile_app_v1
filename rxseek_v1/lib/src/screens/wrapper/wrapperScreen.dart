import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/dialogs/waiting_dialog.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/home/home_screen_final.dart';
import 'package:rxseek_v1/src/screens/profile/profile_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          backgroundColor: Colors.white,
          elevation: 0.0,
          selectedLabelStyle: const TextStyle(
            fontSize: 14, // Change font size
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand', // Make it bold
            color:
                Colors.blue, // Not used here, use `selectedItemColor` instead
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12, // Smaller for unselected items
            fontWeight: FontWeight.normal, // Normal weight
          ),
          selectedItemColor: const Color(0xff37B1B8), // Color for selected item
          unselectedItemColor: Colors.grey, // Color for unselected items
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/message_vect.svg", // Path to your SVG asset
                  height: 26,
                  width: 26,
                  fit: BoxFit.cover,
                ),
                label: "Chat"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/profile_button_vect.svg", // Path to your SVG asset
                  height: 26,
                  width: 26,
                  fit: BoxFit.cover,
                ),
                label: "Profile"),
          ],
        ),
      ),
    );
  }
}
