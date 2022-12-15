import 'package:chat_gpt_demo/screens/chatgpt_api/flutter_chat_gpt.dart';
import 'package:flutter/material.dart';

//Chat ui widget
class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {super.key, required this.text, required this.chatMessageType});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (chatMessageType == ChatMessageType.bot)
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.computer,
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: chatMessageType == ChatMessageType.bot
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: (chatMessageType == ChatMessageType.bot)
                        ? Colors.green
                        : Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          if (chatMessageType == ChatMessageType.user)
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: const CircleAvatar(
                child: Icon(
                  Icons.person,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
