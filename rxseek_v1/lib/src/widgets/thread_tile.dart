import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/models/thread_model.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/home/chat_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ThreadTile extends StatefulWidget {
  const ThreadTile({
    super.key,
    required this.threads,
    required this.recent,
    required this.saveScreen,
  });

  final List<Thread>? threads;
  final bool recent;
  final bool saveScreen;

  @override
  _ThreadTileState createState() => _ThreadTileState();
}

class _ThreadTileState extends State<ThreadTile> {
  late List<bool> isSaved; // Track saved state for each thread

  @override
  void initState() {
    super.initState();
    isSaved = List.generate(widget.threads!.length, (index) => false);
  }

  void saveThread(int index) {
    MessageController.I.saveThread(widget.threads![index].threadId);
    setState(() {
      isSaved[index] = true;
    });

    Fluttertoast.showToast(
      msg: "Chat saved successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void deleteThread(int index) {
    if (widget.saveScreen) {
      MessageController.I.unsaveThread(widget.threads![index].threadId);
    } else {
      MessageController.I.deleteThread(widget.threads![index].threadId);
    }

    setState(() {
      widget.threads!.removeAt(index);
    });

    print("Deleted Thread");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.recent
          ? widget.threads!.length > 10
              ? 10
              : widget.threads!.length
          : widget.threads!.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return Slidable(
          key: ValueKey(widget.threads![index].threadId),
          startActionPane: ActionPane(
            extentRatio: 0.3,
            motion: const ScrollMotion(),
            children: [
              InkWell(
                onTap: () => saveThread(index),
                child: Image.asset(
                  isSaved[index]
                      ? "assets/images/save_button.png"
                      : "assets/images/unsaved_button.png", // Change asset paths accordingly
                ),
              ),
            ],
          ),
          endActionPane: ActionPane(
            extentRatio: 0.3,
            motion: const ScrollMotion(),
            children: [
              InkWell(
                onTap: () => deleteThread(index),
                child: Image.asset(
                    "assets/images/delete_button.png"), // Add your delete button asset path
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: InkWell(
              onTap: () {
                GlobalRouter.I.router.go(
                  "${ChatScreen.route}/${widget.threads![index].threadId}",
                );
              },
              child: Container(
                height: 91,
                width: 340,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 1, 65, 117),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 200),
                      child: Text(
                        convertToNotMilitaryTime(
                          widget.threads![index].timeCreated.toDate().hour,
                          widget.threads![index].timeCreated.toDate().minute,
                        ),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Text(
                      widget.threads![index].threadName.length > 20
                          ? "${widget.threads![index].threadName.substring(0, 20)}...?"
                          : widget.threads![index].threadName,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String convertToNotMilitaryTime(int hour, int minute) {
    int finalHour = (hour > 12) ? hour - 12 : hour;
    String period = (hour >= 12) ? "PM" : "AM";
    return "$finalHour:${minute.toString().padLeft(2, '0')} $period";
  }
}
