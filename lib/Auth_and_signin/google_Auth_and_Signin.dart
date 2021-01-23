import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthandSignin {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future signUpWithEmailAndPassword(
      {@required String email, @required String password}) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future forgetPassword({@required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
