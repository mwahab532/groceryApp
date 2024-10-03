import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/model/useModel.dart';

class userprovider extends ChangeNotifier {
  // ignore: unused_field
  UserModel _user = UserModel(
    name: "",
    gender: "",
    address: "",
    phone: "",
    country: "",
    city: "",
    userprofile: "",
  );
  UserModel get userdata => _user;
  final Firestore = FirebaseFirestore.instance.collection("Userdetails");

  Future<void> loaduserdata() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userdoc = await Firestore.doc(id).get();
    if (userdoc.exists) {
      _user = UserModel(
        name: userdoc["Name"] ?? "Enter Name",
        gender: userdoc["Gender"] ?? "",
        address: userdoc["Adress"] ?? "",
        phone: userdoc["Phone Number"],
        country: userdoc["Country"] ?? "",
        city: userdoc["City"] ?? "",
        userprofile: userdoc["ImageURL"] ?? "",
      );
      notifyListeners();
    }
  }
}
