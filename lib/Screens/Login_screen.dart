import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sendme/Auth_and_signin/google_Auth_and_Signin.dart';
import 'package:sendme/Screens/Home.dart';
import 'package:sendme/Screens/Signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthandSignin auth = AuthandSignin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("SENDO"),
          centerTitle: true,
          backgroundColor: Colors.indigo),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "SIGN IN",
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
                      controller: emailController,
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
                      decoration: InputDecoration(
                          focusColor: Colors.indigo,
                          labelText: "Enter Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.indigo))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (valid) {
                        if (valid.length < 6) {
                          return "Weak Password";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          focusColor: Colors.indigo,
                          labelText: "Enter Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.indigo))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      child: Text("Forget Password?"),
                      onTap: () {},
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        auth
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) => {
                                  FirebaseFirestore.instance
                                      .collection("User")
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .get()
                                      .then((DocumentSnapshot snapshot) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Home(
                                            uid: FirebaseAuth
                                                .instance.currentUser.uid,
                                            username: snapshot["Name"]),
                                      ),
                                    );
                                  }),
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
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              child: Text(
                "Don't have an account SignUp here!",
                style: TextStyle(color: Colors.indigo),
              ),
            ),
          )
        ],
      ),
    );
  }
}
