// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:chat_firebase/auth/suthService.dart';
import 'package:chat_firebase/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../widgets/mainDraware.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      drawer: MainDraware(),
      body: Consumer<UserProvider>(
        builder: (context, provider, _) =>
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: provider.getUserByUid(AuthService.user!.uid),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              final userModel = UserModel.fromMap(snapshot.data.data());
              
            }
            if (snapshot.hasError) {
              return Text('Failed to fetch data');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
