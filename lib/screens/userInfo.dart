import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/controllers/Feildcontroller.dart';
import 'package:groceryapp/firebase/Userservics.dart';
import 'package:groceryapp/images/images.dart';
import 'package:groceryapp/screens/Home.dart';
import 'package:groceryapp/style/style.dart';
import 'package:groceryapp/widgets/customfeild.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  FeildController feildcontroller = FeildController();
  final formkey = GlobalKey<FormState>();
  final Firestore = FirebaseFirestore.instance.collection("Userdetails");
  // ignore: unused_field
  final ImagePicker _imagepiker = ImagePicker();
  XFile? _iamge;
  final Pickimage images = Pickimage();
  final Uservices _uservices = Uservices();
  bool isuploading = false;

  Future<void> Submite() async {
    setState(() {
      isuploading = true;
    });
    try {
      String userid = FirebaseAuth.instance.currentUser!.uid;
      if (formkey.currentState!.validate()) {
        String? iamgeurl;
        if (_iamge != null) {
          try {
            iamgeurl = await _uservices.uploadstorage(_iamge!, context);
            print(iamgeurl);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Image upload failed: $e")));
            setState(() {
              isuploading = false;
            });
            return;
          }
        }
        try {
          await _uservices.adduserdetails(
            id: userid,
            name: feildcontroller.Namecontroller.text,
            gender: feildcontroller.gendercontroller.text,
            address: feildcontroller.addresscontroller.text,
            phone: feildcontroller.Phonecontroller.text,
            country: feildcontroller.Countrycontroller.text,
            city: feildcontroller.Citycontroller.text,
            iamgeurl: iamgeurl,
            context: context,
          );
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Successfully uploaded your data")));
          final route = MaterialPageRoute(
            builder: (context) => Home(),
          );
          Navigator.push(context, route);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("Failed to upload user data: $e")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("All fields must be filled")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("An unexpected error occurred: $e")));
      setState(() {
        isuploading = false;
      });
    } finally {
      setState(() {
        isuploading = false;
      });
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await images.getimage(source);
      if (image != null) {
        setState(() {
          _iamge = image;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Failed to upload your profile picture."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Setup Profile",
          style: Titletextstyle,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: _iamge != null
                      ? Image.file(
                          File(_iamge!.path),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.person,
                          size: 80,
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  child: Text(
                    "Upload from Gallery",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  child: Text(
                    "Take from Camera",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomSearchField(
                  cursorColor: Colors.black,
                  fillColor: Colors.white,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "This field can't be Empty";
                    }
                  },
                  controller: feildcontroller.Namecontroller,
                  keyboradtype: TextInputType.name,
                  hintname: "Full Name",
                  hintstyle: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 8,
                ),
                CustomSearchField(
                  cursorColor: Colors.black,
                  fillColor: Colors.white,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "This field can't be Empty";
                    }
                  },
                  controller: feildcontroller.gendercontroller,
                  keyboradtype: TextInputType.text,
                  hintname: "Gender",
                  hintstyle: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 8,
                ),
                CustomSearchField(
                  cursorColor: Colors.black,
                  fillColor: Colors.white,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "This field can't be Empty";
                    }
                  },
                  controller: feildcontroller.addresscontroller,
                  keyboradtype: TextInputType.streetAddress,
                  hintname: "Home Address",
                  hintstyle: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 8,
                ),
                CustomSearchField(
                  cursorColor: Colors.black,
                  fillColor: Colors.white,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "This field can't be Empty";
                    }
                  },
                  controller: feildcontroller.Phonecontroller,
                  keyboradtype: TextInputType.phone,
                  hintname: "Phone Number",
                  hintstyle: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 8,
                ),
                CustomSearchField(
                  cursorColor: Colors.black,
                  fillColor: Colors.white,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "This field can't be Empty";
                    }
                  },
                  controller: feildcontroller.Countrycontroller,
                  keyboradtype: TextInputType.text,
                  hintname: "Country",
                  hintstyle: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 8,
                ),
                CustomSearchField(
                  cursorColor: Colors.black,
                  fillColor: Colors.white,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "This field can't be Empty";
                    }
                  },
                  controller: feildcontroller.Citycontroller,
                  keyboradtype: TextInputType.text,
                  hintname: "City",
                  hintstyle: TextStyle(color: Colors.grey),
                ),
                isuploading
                    ? CircularProgressIndicator(
                        color: Colors.green,
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.green)),
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => Submite(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
