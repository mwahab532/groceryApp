import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/controllers/Feildcontroller.dart';
import 'package:groceryapp/screens/Home.dart';

class Authservices {
  Logincontroller logincontroller = Logincontroller();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> SignInUserWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        final route = MaterialPageRoute(
          builder: (context) => Home(),
        );
        Navigator.push(context, route);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Successfully  Login.")));
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("The password provided is too weak.")));
        case "email-already-in-use":
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("The account already exists for that email")));

        default:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("Failed to sign in: ${e.message}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text("Something went worng")));
    } finally {
      logincontroller.btnController.reset();
    }
  }
}
