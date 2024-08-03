import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";
  static const String name = "Home Screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Center(
            child: Text("HOME SCREEN"),
          ),
          Center(
            child: ElevatedButton(
              child: const Text("SignOut"),
              onPressed: () {
                AuthController.I.logout();
              },
            ),
          )
        ],
      ),
    ));
  }
}
