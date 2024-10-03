import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/model/useModel.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import '../provider/user provider.dart';

class Accountdelete {
    User? userr = FirebaseAuth.instance.currentUser;
      RoundedLoadingButtonController accountdeletbtnController =
      RoundedLoadingButtonController();
        
   void accountdelete(BuildContext context) async {
    try {
      String userId = userr!.uid;
      UserModel user =
          Provider.of<userprovider>(context, listen: false).userdata;

      String userprofileimage = user.userprofile;
      if (userprofileimage.isNotEmpty) {
        await FirebaseStorage.instance.refFromURL(userprofileimage).delete();
      }
      await FirebaseFirestore.instance
          .collection('Userdetails')
          .doc(userId)
          .delete();
      await FirebaseFirestore.instance
          .collection('UserOder')
          .doc(userId)
          .delete();
      await FirebaseFirestore.instance
          .collection('UserFeedback')
          .doc(userId)
          .delete();
      await userr!.delete();
      accountdeletbtnController.success();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text('Account deleted successfully')),
      );
      Navigator.of(context).pushReplacementNamed('/login'); // Example route
    } catch (e) {
      accountdeletbtnController.error();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account: $e')),
      );
    }
  }
}
