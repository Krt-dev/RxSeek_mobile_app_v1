import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxseek_v1/src/Faq/Faq_screen.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/image_controller.dart';
import 'package:rxseek_v1/src/controllers/user_interface_controller.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/auth/change_password_screen.dart';
import 'package:rxseek_v1/src/screens/save_threads/save_thread.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = "/profile";
  static const String name = "Profile Screen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController scrollController;
  late PanelController panelController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    panelController = PanelController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  ChangeProfile() async {
    //pag capture saimage put into an U8intlist type na variable
    var listOfImageResult = await ImageController.I.openCameraAndUploadImage();
    Uint8List img = listOfImageResult[2];
    String userId = AuthController.I.currentUser!.uid;
    //getting image URL paghuman upload gamit ani na function na ato gebuhat
    String imageNetworkUrl =
        await ImageController.I.uploadImageToDb(img, "profileImage/ + $userId");
    //para rebuild sa UI sa consumer widget part
    setState(() {});
    //para update sa profile url na link sa user digtos firebase
    ImageController.I.updateUserProfileUrl(imageNetworkUrl, userId);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SlidingUpPanel(
        controller: panelController,
        minHeight: 360,
        maxHeight: 360,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        body: Scaffold(
          backgroundColor: const Color(0xffd8b689),
          body: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Profile",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: AuthController.I
                          .getUser(AuthController.I.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircleAvatar(
                                  radius: 64,
                                  backgroundImage: AssetImage(
                                      "assets/images/profile_default.jpg")));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData && snapshot.data != null) {
                          return Column(
                            children: [
                              Consumer<UserInterfaceController>(
                                  builder: (context, button, child) {
                                return InkWell(
                                  onTap: () async {
                                    await ChangeProfile();
                                  },
                                  child: Column(
                                    children: [
                                      snapshot.data!.profileUrl != ""
                                          ? CircleAvatar(
                                              radius: 64,
                                              backgroundImage: NetworkImage(
                                                  snapshot.data!.profileUrl),
                                            )
                                          : const CircleAvatar(
                                              radius: 60,
                                              backgroundImage: AssetImage(
                                                  "assets/images/profile_default.jpg"))
                                    ],
                                  ),
                                );
                              }),
                              Text(
                                  "${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'SourceSans3')),
                            ],
                          );
                        } else {
                          return const Center(child: Text('No User is found'));
                        }
                      },
                    ),
                    SizedBox(
                      width: 172,
                      child: Text(
                        "${AuthController.I.currentUser!.email}",
                        style: const TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        panelBuilder: () {
          return ListView(
            controller: scrollController,
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(
                  Icons.bookmark_outline,
                  color: Colors.blue,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(width: 0, color: Colors.transparent),
                ),
                title: const Text(
                  "Saved Chats",
                  style: TextStyle(
                      fontFamily: 'Quicksand', fontWeight: FontWeight.w600),
                ),
                onTap: () => GlobalRouter.I.router.go(SaveThreadScreen.route),
              ),
              ExpansionTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
                trailing: const SizedBox.shrink(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(width: 0, color: Colors.transparent),
                ),
                title: const Text(
                  "Settings",
                  style: TextStyle(
                      fontFamily: 'Quicksand', fontWeight: FontWeight.w600),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () =>
                          GlobalRouter.I.router.go(ChangePasswordScreen.route),
                      child: const Text(
                        "Change Password",
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              ListTile(
                leading: const Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                ),
                title: const Text(
                  "FAQs",
                  style: TextStyle(
                      fontFamily: 'Quicksand', fontWeight: FontWeight.w600),
                ),
                onTap: () => GlobalRouter.I.router.go(FaqScreen.route),
                textColor: Colors.black,
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Log Out",
                ),
                textColor: Colors.red,
                onTap: () {
                  AuthController.I.logout();
                },
              )
            ],
          );
        },
      ),
    );
  }
}
