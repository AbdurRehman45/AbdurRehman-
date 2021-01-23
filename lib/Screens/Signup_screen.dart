import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sendme/Auth_and_signin/google_Auth_and_Signin.dart';
import 'package:sendme/Screens/Home.dart';
import 'package:sendme/Screens/Login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthandSignin auth = AuthandSignin();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("SENDO"),
          centerTitle: true,
          backgroundColor: Colors.indigo),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0.0, 130.0, 0.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
              style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      child: TextFormField(
                        controller: userNameController,
                        validator: (valid) {
                          if (valid.isEmpty) {
                            return "Please Enter Username";
                          }
                        },
                        decoration: InputDecoration(
                            focusColor: Colors.indigo,
                            labelText: "Enter UserName",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.indigo))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      child: TextFormField(
                        validator: (valid) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(valid)) {
                            return "Enter valid email";
                          } else {
                            return null;
                          }
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            focusColor: Colors.indigo,
                            labelText: "Enter Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.indigo))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: TextFormField(
                        validator: (valid) {
                          if (valid.length < 6) {
                            return "Weak Password";
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            focusColor: Colors.indigo,
                            labelText: "Enter Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.indigo))),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          auth
                              .signUpWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((userId) {
                            return FirebaseFirestore.instance
                                .collection("User")
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .set({
                              "userID": FirebaseAuth.instance.currentUser.uid,
                              "Name": userNameController.text,
                            });
                          }).then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home(
                                        username: userNameController.text)));
                          });
                        }
                      },
                      child: Text("SignIn"),
                      textColor: Colors.white,
                      color: Colors.indigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  "Have an account SignIn here!",
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
