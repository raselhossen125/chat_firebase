// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, use_build_context_synchronously, unused_element, use_rethrow_when_possible, avoid_print

import 'package:chat_firebase/auth/authService.dart';
import 'package:chat_firebase/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart';
import '../widgets/mainDraware.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final txtControer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My  Profile'),
      ),
      drawer: MainDraware(),
      body: Consumer<UserProvider>(
        builder: (context, provider, _) =>
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: provider.getUserByUid(AuthService.user!.uid),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              final userModel = UserModel.fromMap(snapshot.data.data());
              return ListView(
                children: [
                  Card(
                    elevation: 4,
                    child: userModel.image == null
                        ? Container(
                            height: 250,
                            width: double.infinity,
                            child: Center(
                              child: Image.asset(
                                'images/R.png',
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : Image.network(
                            userModel.image!,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Text(
                          'Chose  Photo',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff180169),
                            fontSize: 17,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    updateImageCamera();
                                  },
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      border: Border.all(
                                        width: 0.5,
                                        color: Color(0xff180169),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text('Camera'),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 50),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    updateImage();
                                  },
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      border: Border.all(
                                        width: 0.5,
                                        color: Color(0xff180169),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text('Galary'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(userModel.name ?? 'Not Set Yet'),
                          trailing: IconButton(
                            onPressed: () {
                              showInputDialog(
                                Icons.person,
                                'your name',
                                userModel.name,
                                (value) {
                                  provider.updateProfile(
                                      AuthService.user!.uid, {userName: value});
                                  AuthService.updateDisplayNamer(value);
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Color(0xff180169),
                              size: 22,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(userModel.email ?? 'Not Set Yet'),
                          trailing: IconButton(
                            onPressed: () {
                              showInputDialog(
                                Icons.email,
                                'your email address',
                                userModel.email,
                                (value) {
                                  provider.updateProfile(AuthService.user!.uid,
                                      {userEmail: value});
                                  AuthService.updateDisplayEmail(value);
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Color(0xff180169),
                              size: 22,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(userModel.phone ?? 'Not Set Yet'),
                          trailing: IconButton(
                            onPressed: () {
                              showInputDialog(
                                Icons.phone,
                                'your phone number',
                                userModel.phone,
                                (value) {
                                  provider.updateProfile(AuthService.user!.uid,
                                      {userPhone: value});
                                  AuthService.updatePhoneNumber(value);
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Color(0xff180169),
                              size: 22,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
            if (snapshot.hasError) {
              return Text('Failed to fetch data');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void updateImage() async {
    final xFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (xFile != null) {
      try {
        final downloadUrl =
            await Provider.of<UserProvider>(context, listen: false)
                .updateImage(xFile);
        await Provider.of<UserProvider>(context, listen: false)
            .updateProfile(AuthService.user!.uid, {'image': downloadUrl});
        await AuthService.updateDisplayImage(downloadUrl);
      } catch (e) {
        throw e;
      }
    }
  }

  void updateImageCamera() async {
    final xFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 75);
    if (xFile != null) {
      try {
        final downloadUrl =
            await Provider.of<UserProvider>(context, listen: false)
                .updateImage(xFile);
        await Provider.of<UserProvider>(context, listen: false)
            .updateProfile(AuthService.user!.uid, {'image': downloadUrl});
        await AuthService.updateDisplayImage(downloadUrl);
      } catch (e) {
        throw e;
      }
    }
  }

  showInputDialog(
      IconData icon, String title, String? value, Function(String) onSave) {
    txtControer.text = value ?? 'Not Set Yet';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ' + title),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: txtControer,
            cursorColor: Color(0xff180169),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Color(0xff180169), fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              contentPadding: EdgeInsets.only(left: 10),
              focusColor: Colors.grey.withOpacity(0.1),
              prefixIcon: Icon(
                icon,
                color: Color(0xff180169),
              ),
              hintText: 'Enter $title',
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel')),
          TextButton(
            onPressed: () {
              onSave(txtControer.text);
              Navigator.of(context).pop();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
