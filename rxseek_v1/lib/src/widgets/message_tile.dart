import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/user_interface_controller.dart';
import 'package:rxseek_v1/src/models/message_model.dart';

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

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
                        child: Text(
                          message.content,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: AuthController.I
                              .getUser(AuthController.I.currentUser!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                    "assets/images/profile_default.jpg"),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              return Column(
                                children: [
                                  Consumer<UserInterfaceController>(
                                      builder: (context, button, child) {
                                    return CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          snapshot.data!.profileUrl),
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
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
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
                        child: Text(
                          message.content,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
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
                              image: NetworkImage(message.imageUrl),
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
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              return Column(
                                children: [
                                  Consumer<UserInterfaceController>(
                                      builder: (context, button, child) {
                                    return CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          snapshot.data!.profileUrl),
                                    );
                                  }),
                                ],
                              );
                            } else {
                              return const CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    "assets/images/sampleProfile.png"),
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
                        backgroundImage: NetworkImage(
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
                        child: Text(
                          message.content,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
          );
  }
}
