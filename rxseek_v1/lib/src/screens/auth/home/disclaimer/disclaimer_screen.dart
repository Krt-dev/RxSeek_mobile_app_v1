import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/auth/home/home_screen.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});
  static const route = "/disclaimer";
  static const name = "DisclaimerScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              width: 600, // Add width and height constraints
              height: 600,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/Disclaimer picture.png"),
                fit: BoxFit.cover, // Ensure the image covers the container
              )),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            child: ElevatedButton(
                onPressed: () {
                  GlobalRouter.I.router.go(HomeScreen.route);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
