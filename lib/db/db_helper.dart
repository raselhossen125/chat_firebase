// ignore_for_file: unused_local_variable

import 'package:chat_firebase/model/message-model.dart';
import 'package:chat_firebase/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper {
  static const String collectionUsers = 'Users';
  static const String collectionMessages = 'Messages';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel userModel) async {
    final doc = _db.collection(collectionUsers).doc(userModel.uid);
    return doc.set(userModel.toMap());
  }

  static Future<void> addMessage(MessageModel messageModel) async {
    return _db.collection(collectionMessages).doc().set(messageModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return _db
        .collection(collectionUsers)
        .orderBy(userUid, descending: false)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatRoomMessage() => _db
      .collection(collectionMessages)
      .orderBy(mMessageId, descending: true)
      .snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUid(
          String uid) =>
      _db.collection(collectionUsers).doc(uid).snapshots();

  static Future<void> updateProfile(String uid, Map<String, dynamic> map) {
    return _db.collection(collectionUsers).doc(uid).update(map);
  }
}
