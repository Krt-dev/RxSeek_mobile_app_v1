import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/dialogs/waiting_dialog.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";
  static const String name = "Home Screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

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
                onTap: () {
                  WaitingDialog.show(context,
                      future: AuthController.I.logout());
                },
                child: const Icon(
                  Icons.more_vert,
                  size: 50,
                ))
          ],
          title: Image.asset("assets/images/RxSeek_name.png")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: size.height * 0.8,
                width: size.width * 0.99,
                decoration: const BoxDecoration(color: Colors.white),
                child: const Center(
                  child: Text(
                    "Welcome",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * 0.8,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 221, 218, 218),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: size.height * 0.79,
                          width: size.width * 0.5,
                          child: TextField(
                            controller: messageController,
                            decoration: const InputDecoration(
                                hintText: "How can I help?",
                                border: InputBorder.none),
                          ),
                        ),
                        InkWell(
                            onTap: () {},
                            child: Image.asset("assets/images/send_button.png"))
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
      ),
    ));
  }
}
