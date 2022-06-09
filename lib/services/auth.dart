import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_project_app/models/user.dart';
import 'package:flutter_project_app/views/signup.dart';

class AuthService {
  auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  User? _userFromFirebaseUser(auth.User user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //sign in function
  Future signInEmailAndPass(String email, String password) async {
    try {
      auth.UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      auth.User? firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential authResult = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      auth.User? firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
