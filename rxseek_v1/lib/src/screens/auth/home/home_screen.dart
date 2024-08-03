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
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: () {},
            child: Image.asset("assets/images/burger_button.png"),
          ),
          actions: [
            InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.more_vert,
                  size: 50,
                ))
          ],
          title: Image.asset("assets/images/RxSeek_name.png")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            Container(
              height: size.height * 0.8,
              width: size.width * 0.99,
              decoration: const BoxDecoration(color: Colors.blue),
            ),
            Row(
              children: [
                Container(
                  width: size.width * 0.6,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      TextField(),
                      Image.asset("assets/images/send_button.png")
                    ],
                  ),
                ),
                InkWell(
                    onTap: () {},
                    child: Image.asset("assets/images/camera_button.png"))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
