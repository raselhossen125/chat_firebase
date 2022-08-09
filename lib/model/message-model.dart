// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

const String mMessageId = 'msgId';
const String mUserId = 'userId';
const String mUserName = 'userName';
const String mUserImage = 'userImage';
const String mEmail = 'email';
const String mMessage = 'msg';
const String mTimestamp = 'timestamp';
const String mImage = 'image';

class MessageModel {
  int? msgId;
  String? userId;
  String? userName;
  String? userImage;
  String email;
  String msg;
  Timestamp timestamp;
  String? image;

  MessageModel({
    this.msgId,
    this.userId,
    this.userName,
    this.userImage,
    required this.email,
    required this.msg,
    required this.timestamp,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      mMessageId: msgId,
      mUserId: userId,
      mUserName: userName,
      mUserImage: userImage,
      mEmail: email,
      mMessage: msg,
      mTimestamp: timestamp,
      mImage: image,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
        msgId: map[mMessageId],
        userId: map[mUserId],
        userName: map[mUserName],
        userImage: map[mUserImage],
        email: map[mEmail],
        msg: map[mMessage],
        timestamp: map[mTimestamp],
        image: map[mImage],
      );
}
