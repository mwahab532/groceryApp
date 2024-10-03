import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/controllers/Feildcontroller.dart';
import 'package:groceryapp/style/style.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

// ignore: must_be_immutable
class FeedBack extends StatefulWidget {
  FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  Displaycontroller displaycontroller = Displaycontroller();

  final userfeedbackFirestore =
      FirebaseFirestore.instance.collection("UserFeedback");

  String userid = FirebaseAuth.instance.currentUser!.uid;

  Future sendfeedback(BuildContext context) async {
    userfeedbackFirestore.doc(userid).set({
      'Feedback': displaycontroller.feedbackcontroller.text,
    }).then((value) {
      displaycontroller.feedbackbtnController.success();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Tankyou for your FeedBack')));
      displaycontroller.feedbackbtnController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "FeedBack",
          style: Titletextstyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.green, width: 3),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: displaycontroller.feedbackcontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write your FeedBack here....",
                        hintStyle: TextStyle(color: Colors.grey)),
                    minLines: 1,
                    maxLines: 6,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            RoundedLoadingButton(
              color: Colors.green,
              controller: displaycontroller.feedbackbtnController,
              child: Text(
                "Send FeedBack",
                style: roudedbuttonstyle,
              ),
              onPressed: () {
                setState(() {
                  sendfeedback(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
