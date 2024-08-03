import 'package:flutter/material.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});
  static const route = "/disclaimer";
  static const name = "DisclaimerScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disclaimer Place Holder"),
      ),
    );
  }
}
