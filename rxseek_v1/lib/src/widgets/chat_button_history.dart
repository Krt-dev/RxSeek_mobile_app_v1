import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxseek_v1/src/controllers/user_interface_controller.dart';

class ChatButtonHistory extends StatelessWidget {
  const ChatButtonHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInterfaceController>(builder: (context, button, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 70, bottom: 15),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          InkWell(
            onTap: () {
              Provider.of<UserInterfaceController>(context, listen: false)
                  .handleTapAlllButton();
              print("tapped All");
            },
            child: Container(
              width: 65,
              height: 30,
              decoration: button.recent
                  ? BoxDecoration(
                      border: const Border.symmetric(
                          vertical:
                              BorderSide(style: BorderStyle.solid, width: 1),
                          horizontal:
                              BorderSide(style: BorderStyle.solid, width: 1)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    )
                  : BoxDecoration(
                      color: const Color.fromARGB(255, 1, 65, 117),
                      borderRadius: BorderRadius.circular(8),
                    ),
              child: Center(
                  child: Text("All",
                      style: button.recent
                          ? const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600)
                          : const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 80),
            child: InkWell(
              onTap: () {
                Provider.of<UserInterfaceController>(context, listen: false)
                    .handleTapRecentButton();

                print("tapped Recent");
              },
              child: Container(
                width: 65,
                height: 30,
                decoration: button.recent
                    ? BoxDecoration(
                        color: const Color.fromARGB(255, 1, 65, 117),
                        borderRadius: BorderRadius.circular(8),
                      )
                    : BoxDecoration(
                        border: const Border.symmetric(
                            vertical:
                                BorderSide(style: BorderStyle.solid, width: 1),
                            horizontal:
                                BorderSide(style: BorderStyle.solid, width: 1)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                child: Center(
                    child: Text(
                  "Recent",
                  style: button.recent
                      ? const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600)
                      : const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600),
                )),
              ),
            ),
          ),
        ]),
      );
    });
  }
}
