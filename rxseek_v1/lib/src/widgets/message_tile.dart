import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/user_interface_controller.dart';
import 'package:rxseek_v1/src/models/message_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return message.imageUrl == ""
        ? Align(
            alignment: message.sender == "user"
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: message.sender == "user"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: message.sender == "user"
                                ? Colors.blueAccent
                                : const Color(0xFFE1BD8F),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MarkdownBody(
                            data: message.content,
                            styleSheet: MarkdownStyleSheet(
                              p: const TextStyle(color: Colors.white),
                              strong: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          )
                          // child: Text(
                          //   message.content,
                          //   style: const TextStyle(
                          //     color: Colors.white,
                          //   ),
                          // ),
                          ),
                      FutureBuilder(
                          future: AuthController.I
                              .getUser(AuthController.I.currentUser!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              return Column(
                                children: [
                                  Consumer<UserInterfaceController>(
                                      builder: (context, button, child) {
                                    return snapshot.data!.profileUrl != ""
                                        ? CircleAvatar(
                                            radius: 20,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    snapshot.data!.profileUrl),
                                          )
                                        : const CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                                "assets/images/profile_default.jpg"),
                                          );
                                  }),
                                ],
                              );
                            } else {
                              return const CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                      "assets/images/profile_default.jpg"));
                            }
                          }),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors
                            .transparent, // optional if you want no background
                        child: ClipOval(
                          child: SvgPicture.network(
                            "https://firebasestorage.googleapis.com/v0/b/rxseek-b60ba.appspot.com/o/profileImage%2FGroup%204.svg?alt=media&token=ded14c13-4c6e-498b-83e2-08d2fafd3faa",
                            width: 40, // Adjust size as needed
                            height: 40, // Adjust size as needed
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: message.sender == "user"
                                ? Colors.blueAccent
                                : const Color(0xFFE1BD8F),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MarkdownBody(
                            data: message.content,
                            styleSheet: MarkdownStyleSheet(
                              p: const TextStyle(color: Colors.white),
                              strong: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          )
                          // child: Text(
                          //   message.content,
                          //   style: const TextStyle(
                          //     color: Colors.white,
                          //   ),
                          // ),
                          ),
                    ],
                  ),
          )
        : Align(
            alignment: message.sender == "user"
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: message.sender == "user"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        // padding: const EdgeInsets.all(12.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        height: 370,
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                          //ge addan nako shadow mga brad ron mas nice
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          image: DecorationImage(
                              image:
                                  CachedNetworkImageProvider(message.imageUrl),
                              fit: BoxFit.cover),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // child: Container(
                        //   width: MediaQuery.of(context).size.width * 0.75,
                        //   child: Image.network(message.imageUrl),
                        // ),
                      ),
                      FutureBuilder(
                          future: AuthController.I
                              .getUser(AuthController.I.currentUser!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              return Column(
                                children: [
                                  Consumer<UserInterfaceController>(
                                      builder: (context, button, child) {
                                    return snapshot.data!.profileUrl != ""
                                        ? CircleAvatar(
                                            radius: 20,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    snapshot.data!.profileUrl),
                                          )
                                        : const CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                                "assets/images/profile_default.jpg"),
                                          );
                                  }),
                                ],
                              );
                            } else {
                              return const CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                    "assets/images/profile_default.jpg"),
                              );
                            }
                          }),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: CachedNetworkImageProvider(
                            "https://firebasestorage.googleapis.com/v0/b/rxseek-b60ba.appspot.com/o/profileImage%2FsystemProfile.png?alt=media&token=29ac9f84-e001-45c8-b37f-764033e9724c"),
                      ),
                      Container(
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: message.sender == "user"
                                ? Colors.blueAccent
                                : const Color(0xFFE1BD8F),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MarkdownBody(
                            data: message.content,
                            styleSheet: MarkdownStyleSheet(
                              p: const TextStyle(color: Colors.white),
                              strong: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          )
                          // child: Text(
                          //   message.content,
                          //   style: const TextStyle(
                          //     color: Colors.white,
                          //   ),
                          // ),
                          ),
                    ],
                  ),
          );
  }
}
