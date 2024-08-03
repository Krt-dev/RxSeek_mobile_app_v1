import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/routing/router.dart';
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
        body: Center(
          child: Image.asset('assets/imgaes/rxseek_logo_name.png'),
        ));
  }
}
