// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, prefer_if_null_operators, unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../widgets/mainDraware.dart';

class UserListPage extends StatefulWidget {
  static const routeName = '/user-list';

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<UserProvider>(context, listen: false).getAllUsers();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User  List'),
      ),
      drawer: MainDraware(),
      body: Consumer<UserProvider>(
        builder: (context, provider, _) => ListView.builder(
          itemCount: provider.allUserList.length,
          itemBuilder: (context, index) {
            final user = provider.allUserList[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: user.image == null
                    ? Image.asset(
                        'images/R.png',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        user.image!,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
              ),
              title: Text(user.name == null ? user.email! : user.name!),
            );
          },
        ),
      ),
    );
  }
}
