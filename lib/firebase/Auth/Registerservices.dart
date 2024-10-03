import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/controllers/Feildcontroller.dart';

class Registerservices {
  Registercontroller registercontroller = Registercontroller();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Successfully Register.")));
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("The password provided is too weak.")));

          break;
        case "email-already-in-use":
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("The account already exists for that email")));

          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("Failed to sign in: ${e.message}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text("Something went wrong")));
    } finally {
      registercontroller.btnController.reset();
    }
  }
}
