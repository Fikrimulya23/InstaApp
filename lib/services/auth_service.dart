import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/pages/wait_page.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future signUpEmail(
      String _email, String _password, BuildContext buildContext) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(buildContext).pop(); //regrese a la pantalla anterior
      });
      print("berhasil daftar");
    } catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text('Weak password, minimum 6 characters')));
      } else if (_email.isEmpty) {
        ScaffoldMessenger.of(buildContext)
            .showSnackBar(SnackBar(content: Text('email is still empty')));
      } else if (_password.isEmpty) {
        ScaffoldMessenger.of(buildContext)
            .showSnackBar(SnackBar(content: Text('password is still empty')));
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text('Please enter a valid email')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text('Email is already registered')));
      } else {
        print(e);
      }
    }
  }

  Future signInEmail() async {
    await _auth.signInWithEmailAndPassword(
        email: 'Fikri@gmail.com', password: '123456');
  }
}
