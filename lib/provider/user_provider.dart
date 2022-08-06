import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../db/db_helper.dart';
import '../model/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> allUserList = [];

  Future<void> addUser(UserModel userModel) => DBHelper.addUser(userModel);

  getAllUsers() {
    DBHelper.getAllUsers().listen((snapshort) {
      allUserList = List.generate(snapshort.docs.length,
          (index) => UserModel.fromMap(snapshort.docs[index].data()));
      notifyListeners();
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUid(String uid) =>
    DBHelper.getUserByUid(uid);
}
