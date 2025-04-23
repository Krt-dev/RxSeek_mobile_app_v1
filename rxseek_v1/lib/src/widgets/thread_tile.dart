import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/models/thread_model.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/home/chat_screen.dart';

class ThreadTile extends StatelessWidget {
  const ThreadTile(
      {super.key,
      required this.threads,
      required this.recent,
      required this.saveScreen});

  final List<Thread>? threads;
  final bool recent;
  final bool saveScreen;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: recent
          ? threads!.length > 10
              ? 10
              : threads!.length
          : threads!.length,
      // itemCount: threads!.length > 10 ? 10 : threads!.length,

      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return Slidable(
          key: ValueKey(threads![index].threadId),
          startActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const ScrollMotion(),
              children: [
                InkWell(
                    onTap: () {
                      MessageController.I.saveThread(threads![index].threadId);
                      // ignore: avoid_print
                      print("save Thread");
                    },
                    child: Image.asset("assets/images/save_button.png")),
              ]),
          endActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const ScrollMotion(),
              children: [
                InkWell(
                  onTap: () {
                    saveScreen
                        ? MessageController.I
                            .unsaveThread(threads![index].threadId)
                        : MessageController.I
                            .deleteThread(threads![index].threadId);
                    // ignore: avoid_print
                    print("deleted Thread");
                  },
                  child: Image.asset("assets/images/delete_button.png"),
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: InkWell(
              onTap: () {
                GlobalRouter.I.router
                    .push("${ChatScreen.route}/${threads![index].threadId}");
              },
              child: Container(
                height: 91,
                width: 340,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 1, 65, 117),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 200),
                    child: Text(
                      convertToPhilippineTime(threads![index].timeCreated),
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Text(
                    threads![index].threadName.length > 20
                        ? "${threads![index].threadName.substring(0, 20)}...?"
                        : threads![index].threadName,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w400),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  String convertToPhilippineTime(Timestamp? timestamp) {
    if (timestamp == null) return 'No date available';

    // Convert to DateTime object
    final dateTime = timestamp.toDate();

    // Setting timezone to Philippines (UTC+8)
    final philippineDateTime = dateTime.add(const Duration(hours: 8));

    // Format the date/time
    final formatter = DateFormat('hh:mm a');
    return formatter.format(philippineDateTime);
  }
}
