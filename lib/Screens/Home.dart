import 'package:flutter/material.dart';
import 'package:sendme/Auth_and_signin/google_Auth_and_Signin.dart';

import 'Login_screen.dart';

class Home extends StatefulWidget {
  var username;
  var uid;
  Home({this.uid, @required this.username});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthandSignin auth = AuthandSignin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hello  " + widget.username),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                auth.signOut().then((value) => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()))
                    });
              })
        ],
      ),
    );
  }
}
