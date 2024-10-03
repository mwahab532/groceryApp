import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Uservices {
  final FirebaseFirestore Firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> adduserdetails({
    required String id,
    required String name,
    required String gender,
    required String address,
    required String phone,
    required String country,
    required String city,
     String? iamgeurl,
    required BuildContext context,
  }) async {
    try {
      await Firestore.collection("Userdetails").doc(id).set({
        "Id": id,
        "Name": name,
        "Gender": gender,
        'Adress': address,
        'Phone Number': phone,
        'Country': country,
        'City': city,
        'ImageURL': iamgeurl,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to upload your data: ${e.toString()}")));
    }
  }

  Future<String?> uploadstorage(XFile file, BuildContext context) async {
    String userid = FirebaseAuth.instance.currentUser!.uid;
    try {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child("Profileimage/$userid/${file.name}");
      UploadTask uploadTask = storageRef.putFile(File(file.path));
      await uploadTask;
      // Retrieve the download URL after uploading
      String downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to upload image ")));
    }
    return null;
  }
}
