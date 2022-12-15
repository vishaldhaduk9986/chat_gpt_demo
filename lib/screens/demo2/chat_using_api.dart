import 'package:chat_gpt_demo/screens/api/api.dart';
import 'package:chat_gpt_demo/screens/demo1/chat_message_widget.dart';
import 'package:chat_gpt_demo/screens/chatgpt_api/flutter_chat_gpt.dart';

import 'package:flutter/material.dart';

class GptChatAPIDemo extends StatefulWidget {
  const GptChatAPIDemo({
    super.key,
  });

  @override
  State<GptChatAPIDemo> createState() => _GptChatAPIDemoState();
}

class _GptChatAPIDemoState extends State<GptChatAPIDemo> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool isLoading = false;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  IconButton _buildSubmit() {
    return IconButton(
      icon: const Icon(Icons.send),
      onPressed: () async {
        if (_textController.text.isNotEmpty) {
          setState(
            () {
              isLoading = true;
              _messages.add(
                ChatMessage(
                  text: _textController.text,
                  chatMessageType: ChatMessageType.user,
                ),
              );
            },
          );
          // Save the input and clearing the text field.
          var input = _textController.text;
          _textController.clear();

          var newMessage = await API.shared.getMessage(input);

          setState(() {
            isLoading = false;
            _messages.add(
              ChatMessage(
                text: newMessage['choices'][0]['text'],
                chatMessageType: ChatMessageType.bot,
              ),
            );
          });
          _textController.clear();

          //  Needs a delay or the scroll won't always work.
          Future.delayed(const Duration(milliseconds: 50))
              .then((_) => _scrollDown());
        }
      },
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        controller: _textController,
        decoration: const InputDecoration(
          hintText: 'Enter a message',
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('text-davinci-003'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: _buildList(),
              ),
              (isLoading) ? const CircularProgressIndicator() : Container(),
              Row(
                children: [
                  _buildInput(),
                  _buildSubmit(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
