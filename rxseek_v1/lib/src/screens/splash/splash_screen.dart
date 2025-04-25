import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/auth/login.screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 200.0, left: 20),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/rxseek_logo_name.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 65,
            bottom: 50, // Move spinner slightly up to make space for GIF
            child: SpinKitFadingCube(
              color: Color(0xffe37B1B8),
              size: 50.0,
            ),
          ),
          Positioned(
            bottom: 50,
            child: Image.asset(
              'assets/gifs/Sequence 01.gif',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
