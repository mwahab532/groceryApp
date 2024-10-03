import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/controllers/Feildcontroller.dart';
import 'package:groceryapp/firebase/Account%20delete.dart';
import 'package:groceryapp/images/images.dart';
import 'package:groceryapp/model/useModel.dart';
import 'package:groceryapp/style/style.dart';
import 'package:groceryapp/widgets/Quick.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import '../provider/user provider.dart';

// ignore: must_be_immutable
class Accountdetails extends StatefulWidget {
  Accountdetails({super.key});

  @override
  State<Accountdetails> createState() => _AccountdetailsState();
}

class _AccountdetailsState extends State<Accountdetails> {
  final Firestore = FirebaseFirestore.instance.collection("Userdetails");
  User? userr = FirebaseAuth.instance.currentUser;
  // ignore: unused_field
  final ImagePicker _imagepiker = ImagePicker();

  XFile? _iamge;
  final Pickimage images = Pickimage();
  Displaycontroller displaycontroller = Displaycontroller();

  Future<void> pickanduploadImage(ImageSource source) async {
    try {
      final image = await images.getimage(source);
      if (image != null) {
        setState(() {
          _iamge = image;
        });
        String userId = userr!.uid;
        UserModel user =
            Provider.of<userprovider>(context, listen: false).userdata;
        String oldprofileiamgeUrl = user.userprofile;
        if (oldprofileiamgeUrl.isNotEmpty) {
          try {
            await FirebaseStorage.instance
                .refFromURL(oldprofileiamgeUrl)
                .delete();
          } catch (e) {
            print("Error deleting old profile image: $e");
          }
        }
        Reference storageRef = FirebaseStorage.instance
            .ref()
            .child("Profileimage/$userId/${image.name}");
        UploadTask uploadTask = storageRef.putFile(File(image.path));
        // ignore: unused_local_variable
        TaskSnapshot taskSnapshot = await uploadTask;
        String newprofileurl = await storageRef.getDownloadURL();
        Firestore.doc(userId).update({
          'ImageURL': newprofileurl,
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Profile picture updated successfully!"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Failed to upload your profile picture."),
      ));
    }
  }

  @override
  void initState() {
    Provider.of<userprovider>(context, listen: false).loaduserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<userprovider>(context).userdata;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Account Info",
          style: Titletextstyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              backgroundImage: _iamge != null
                  ? FileImage(File(_iamge!.path))
                  : (user.userprofile.isNotEmpty
                      ? NetworkImage(user.userprofile)
                      : null) as ImageProvider<Object>?,
              child: _iamge == null && user.userprofile.isEmpty
                  ? Icon(Icons.person)
                  : null,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green)),
              child: Text(
                "Change Profile Picture",
                style: cartbuttonstyle,
              ),
              onPressed: () {
                pickanduploadImage(ImageSource.gallery);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    quickmessagedfeilds(
                      textname: "Name",
                      controller: displaycontroller.Displaynamecontroller,
                      hintname: user.name,
                    ),
                    Divider(),
                    quickmessagedfeilds(
                      textname: "Email",
                      controller: displaycontroller.emailcontroller,
                      hintname: userr!.email ?? "".toString(),
                    ),
                    Divider(),
                    quickmessagedfeilds(
                      textname: "Gender",
                      controller: displaycontroller.gendercontroller,
                      hintname: user.gender,
                    ),
                    Divider(),
                    quickmessagedfeilds(
                      textname: "Home address",
                      controller: displaycontroller.addresscontroller,
                      hintname: user.address,
                    ),
                    Divider(),
                    quickmessagedfeilds(
                      textname: "Phone Number",
                      controller: displaycontroller.Phonecontroller,
                      hintname: user.phone,
                    ),
                    Divider(),
                    quickmessagedfeilds(
                      textname: "Country",
                      controller: displaycontroller.Countrycontroller,
                      hintname: user.country,
                    ),
                    Divider(),
                    quickmessagedfeilds(
                      textname: "City",
                      controller: displaycontroller.Citycontroller,
                      hintname: user.city,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            RoundedLoadingButton(
              color: Colors.red,
              controller: Accountdelete().accountdeletbtnController,
              child: Text(
                "Delete Account",
                style: roudedbuttonstyle,
              ),
              onPressed: () {
                Accountdelete().accountdelete(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
