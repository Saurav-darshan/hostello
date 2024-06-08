import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class firebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signupwithemailandpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        log("used");
        //Fluttertoast.showToast(msg: 'The email address is already in use.');
      } else {
        log("error");
      }
    }
    return null;
  }

  Future<User?> signinwithemailandpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseException catch (e) {
      //Fluttertoast.showToast(msg: 'An error occurred: ${e.code}');
      Fluttertoast.showToast(
        msg: "\t${e.code}\t\t",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Color.fromARGB(255, 6, 83, 145),
        textColor: Colors.white,
      );
    }
    return null;
  }
}
