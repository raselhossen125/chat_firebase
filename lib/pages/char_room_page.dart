// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, unused_local_variable, avoid_function_literals_in_foreach_calls

import 'package:chat_firebase/provider/chat_room_provider.dart';
import 'package:chat_firebase/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/mainDraware.dart';

class ChatRoomPage extends StatefulWidget {
  static const routeName = '/chat-room';

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  bool isInit = true;
  final messageController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<ChatRoomProvider>(context, listen: false)
          .getAllChatRoomMessage();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      drawer: MainDraware(),
      body: Consumer<ChatRoomProvider>(
        builder: (context, provider, _) => Column(
          children: [
            Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: provider.messageList.length,
                  itemBuilder: (context, index) {
                    final msg = provider.messageList[index];
                    return MessageItem(messageModel: msg);
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      cursorColor: Color(0xff180169),
                      style: TextStyle(
                          color: Color(0xff180169), fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        contentPadding: EdgeInsets.only(left: 10),
                        focusColor: Colors.white,
                        hintText: "Enter the message",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      provider.addMessage(messageController.text);
                      messageController.clear();
                    },
                    icon: Icon(Icons.send),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
