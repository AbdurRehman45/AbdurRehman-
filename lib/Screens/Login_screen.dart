import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sendme/Screens/sendo_Main_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  bool isLoggedIn = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;

  void isSignedIn() async {
    //SharedPreferences pref = await SharedPreferences.getInstance();
    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SendoMainPage(
                  //   currentUserId: pref.get("id"),
                  )));
    } else {
      Fluttertoast.showToast(msg: "User not Signed In");
    }
  }

  @override
  void initState() {
    isSignedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50.0,
            ),
            Form(
                key: _formKey,
                child: Container(
                  width: 300.0,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please Enter Email";
                          } else if (!value.contains("@") ||
                              !value.contains(".")) {
                            return "Please Enter Original Email";
                          }
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.9, color: Colors.indigo)),
                            hintText: "Enter Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    style: BorderStyle.solid,
                                    color: Colors.indigo))),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (String value) {
                          if (value.length < 6) {
                            return "Enter Password Greater than 6 digits";
                          }
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.9, color: Colors.indigo)),
                            hintText: "Enter Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    style: BorderStyle.solid,
                                    color: Colors.indigo))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Fluttertoast.showToast(msg: "Please Wait");
                          }
                        },
                        child: Text("Login"),
                        color: Colors.indigo,
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.white,
                        padding: EdgeInsets.all(10.0),
                        child: Text("Sign In with GOOGLE"),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
