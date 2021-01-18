import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sendme/Screens/Login_screen.dart';
import 'Screens/sendo_Main_Page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.indigo, shadowColor: Colors.black, elevation: 2.8),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
        floatingActionButtonTheme: FloatingActionButtonThemeData(),
      ),
      title: "Sendo",
      home: MyHome(),
    ),
  );
}

class MyHome extends StatelessWidget {
  Future<DocumentSnapshot> getfireBaseData() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getfireBaseData(),
        builder: (context, snapShot) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Sendo"),
            ),
            body: LoginPage(),
          );
        });
  }
}
