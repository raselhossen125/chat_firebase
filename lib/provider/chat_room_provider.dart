// ignore_for_file: unused_local_variable

import 'package:chat_firebase/auth/authService.dart';
import 'package:chat_firebase/db/db_helper.dart';
import 'package:chat_firebase/model/message-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChatRoomProvider extends ChangeNotifier {
  List<MessageModel> messageList = [];

  Future<void> addMessage(String message) {
    final messageModel = MessageModel(
      msgId: DateTime.now().millisecondsSinceEpoch,
      userId: AuthService.user!.uid,
      userName: AuthService.user!.displayName,
      userImage: AuthService.user!.photoURL,
      email: AuthService.user!.email!,
      msg: message,
      timestamp: Timestamp.fromDate(DateTime.now()),
    );
    return DBHelper.addMessage(messageModel);
  }

  getAllChatRoomMessage() {
    DBHelper.getAllChatRoomMessage().listen((snapsort) {
      messageList = List.generate(snapsort.docs.length,
          (index) => MessageModel.fromMap(snapsort.docs[index].data()));
          notifyListeners();
    });
  }
}
