// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:chat_firebase/auth/authService.dart';
import 'package:chat_firebase/model/message-model.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  MessageModel messageModel;

  MessageItem({
    required this.messageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Column(
        crossAxisAlignment: messageModel.userId == AuthService.user!.uid
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          messageModel.userId == AuthService.user!.uid
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Chip(
                      label: Text(messageModel.msg),
                    ),
                    SizedBox(width: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: messageModel.userImage == null
                          ? Image.asset(
                              'images/R.png',
                              height: 25,
                              width: 25,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              messageModel.userImage!,
                              height: 25,
                              width: 25,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: messageModel.userImage == null
                          ? Image.asset(
                              'images/R.png',
                              height: 25,
                              width: 25,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              messageModel.userImage!,
                              height: 25,
                              width: 25,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Chip(
                      label: Text(messageModel.msg),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
