import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/Login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MaterialApp(
    title: "Sendo",
    theme: ThemeData(primaryColor: Colors.indigo, accentColor: Colors.indigo),
    home: LoginScreen(),
  ));
}
