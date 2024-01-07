import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_firebase/view/register_page.dart';
import 'package:use_firebase/view_model/register_view_model.dart';

import '../view/main_page.dart';
import 'main_view_model.dart';

class LoginViewModel with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void login(BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _openMainPage(context);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  void openRegisterPage(BuildContext context) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => RegisterViewModel(),
              child: RegisterPage(),
            ));
    Navigator.pushReplacement(context, pageRoute);
  }

  void _openMainPage(BuildContext context) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => MainViewModel(),
              child: MainPage(),
            ));
    Navigator.pushReplacement(context, pageRoute);
  }
}
