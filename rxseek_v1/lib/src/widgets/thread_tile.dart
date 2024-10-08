import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/models/thread_model.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/home/chat_screen.dart';

class ThreadTile extends StatelessWidget {
  const ThreadTile({
    super.key,
    required this.threads,
    required this.recent,
  });

  final List<Thread>? threads;
  final bool recent;

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
                    MessageController.I.deleteThread(threads![index].threadId);
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
                    .go("${ChatScreen.route}/${threads![index].threadId}");
              },
              child: Container(
                height: 91,
                width: 340,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 1, 65, 117),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  Text(
                    "${convertToNotMilitaryTime(threads![index].timeCreated.toDate().hour, threads![index].timeCreated.toDate().minute)}",
                    style: const TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  Text(
                    threads![index].threadName,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  String convertToNotMilitaryTime(int hour, int minute) {
    int finalHour = 0;
    if (hour > 12) {
      finalHour = hour - 12;
      return "$finalHour:${minute} PM";
    } else {
      return "$hour:${minute} AM";
    }
  }
}
