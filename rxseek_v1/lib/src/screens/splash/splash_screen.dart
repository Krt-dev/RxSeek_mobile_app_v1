import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/enum/enum.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/auth/home/home_screen.dart';
import 'package:rxseek_v1/src/screens/auth/login.screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/splash";
  static const String name = "Splash Screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      GlobalRouter.I.router.go(LoginScreen.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 200.0, left: 20),
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/rxseek_logo_name.png'),
                    fit: BoxFit.contain)),
          ),
        ));
  }
}
