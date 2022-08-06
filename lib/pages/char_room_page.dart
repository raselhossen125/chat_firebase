// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import '../widgets/mainDraware.dart';

class ChatRoomPage extends StatelessWidget {
  static const routeName = '/chat-room';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      drawer: MainDraware(),
    );
  }
}