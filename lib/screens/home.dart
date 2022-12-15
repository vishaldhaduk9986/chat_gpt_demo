import 'package:chat_gpt_demo/screens/demo1/webview.dart';
import 'package:chat_gpt_demo/screens/demo2/chat_using_api.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  Widget button(title, onPressItem) {
    return ElevatedButton(
      child: Text(
        title,
        style: const TextStyle(fontSize: 20.0),
      ),
      onPressed: () {
        onPressItem();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Gpt Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            button(
                'text-davinci-002-render',
                () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Webview()))
                    }),
            button(
                'text-davinci-003',
                () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const GptChatAPIDemo())),
                    }),
          ],
        ),
      ),
    );
  }
}
