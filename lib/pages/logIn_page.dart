// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'package:chat_firebase/auth/authService.dart';
import 'package:chat_firebase/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart';
import 'launcher_page.dart';

class LogInPage extends StatefulWidget {
  static const routeName = 'log-in';

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool passObsecure = true;
  String error = '';
  bool isLogIn = true;
  final formkey = GlobalKey<FormState>();

  final email_Controller = TextEditingController();
  final password_Controller = TextEditingController();

  @override
  void dispose() {
    email_Controller.dispose();
    password_Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Welcome User',
                    style: TextStyle(
                      color: Color(0xff180169),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset('images/R.png'),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email_Controller,
                          cursorColor: Color(0xff180169),
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: Color(0xff180169),
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            contentPadding: EdgeInsets.only(left: 10),
                            focusColor: Colors.grey.withOpacity(0.1),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xff180169),
                            ),
                            hintText: "Enter Email",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field must not be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: password_Controller,
                          obscureText: passObsecure,
                          cursorColor: Color(0xff180169),
                          style: TextStyle(
                              color: Color(0xff180169),
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            errorText: error,
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            contentPadding: EdgeInsets.only(left: 10),
                            focusColor: Colors.grey.withOpacity(0.1),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff180169),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                passObsecure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xff180169),
                              ),
                              onPressed: () {
                                setState(() {
                                  passObsecure = !passObsecure;
                                });
                              },
                            ),
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field must not be empty';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  InkWell(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      isLogIn = true;
                      authenticate();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xff180169),
                      ),
                      child: Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 45,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 20),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'New User?  Register Here',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      onPressed: () {
                        isLogIn = false;
                        authenticate();
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  authenticate() async {
    if (formkey.currentState!.validate()) {
      try {
        bool status;
        if (isLogIn) {
          status = await AuthService.logIn(
              email_Controller.text, password_Controller.text);
        } else {
          status = await AuthService.register(
              email_Controller.text, password_Controller.text);
          final userModel = UserModel(
            uid: AuthService.user!.uid,
            email: AuthService.user!.email,
          );
          Provider.of<UserProvider>(context, listen: false).addUser(userModel);
        }
        if (status) {
          Navigator.pushReplacementNamed(context, LauncherPage.routeName);
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          error = e.message!;
        });
      }
    }
  }
}
