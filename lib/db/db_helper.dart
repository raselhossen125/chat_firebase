import 'package:chat_firebase/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper {
  static const String collectionUsers = 'Users';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel userModel) async {
    final doc = _db.collection(collectionUsers).doc(userModel.uid);
    return doc.set(userModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return _db
        .collection(collectionUsers)
        .orderBy(userUid, descending: false)
        .snapshots();
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUid(String uid) =>
      _db.collection(collectionUsers).doc(uid).snapshots();
}
