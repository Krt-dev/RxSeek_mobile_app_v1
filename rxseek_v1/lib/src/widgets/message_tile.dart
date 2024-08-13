import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/models/message_model.dart';

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.sender == "user"
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color:
              message.sender == "user" ? Colors.blueAccent : Color(0xFFE1BD8F),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message.content,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
