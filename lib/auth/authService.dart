// ignore_for_file: file_names, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? get user => _auth.currentUser;

  static Future<bool> logIn(String email, String password) async {
    final credensial = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credensial.user != null;
  }

  static Future<bool> register(String email, String password) async {
    final credensial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credensial.user != null;
  }

  static Future<void> logOut() => _auth.signOut();

  static Future<void> updateDisplayNamer(String name) =>
      _auth.currentUser!.updateDisplayName(name);

  static Future<void> updateDisplayImage(String image) =>
      _auth.currentUser!.updatePhotoURL(image);

  static Future<void> updateDisplayEmail(String email) =>
      _auth.currentUser!.updateEmail(email);

  static Future<void> updatePhoneNumber(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationid, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationid) {},
    );
  }
}
