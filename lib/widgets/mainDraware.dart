// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import '../auth/suthService.dart';
import '../pages/char_room_page.dart';
import '../pages/launcher_page.dart';
import '../pages/profile_page.dart';
import '../pages/user_list_page.dart';

class MainDraware extends StatelessWidget {
  const MainDraware({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 200,
            color: Color(0xff180169),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ProfilePage.routeName);
            },
            leading: Icon(Icons.person),
            title: Text('Profile'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ChatRoomPage.routeName);
            },
            leading: Icon(Icons.chat),
            title: Text('Chat Room'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserListPage.routeName);
            },
            leading: Icon(Icons.person),
            title: Text('User Listt'),
          ),
          ListTile(
            onTap: () {
              AuthService.logOut();
              Navigator.of(context).pushReplacementNamed(LauncherPage.routeName);
            },
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
