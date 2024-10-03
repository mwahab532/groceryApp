import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/controllers/Feildcontroller.dart';
import 'package:groceryapp/screens/Accountdetials.dart';
import 'package:groceryapp/screens/OderHistory.dart';
import 'package:groceryapp/screens/Rateapp.dart';
import 'package:groceryapp/screens/feedback.dart';
import 'package:groceryapp/style/style.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  String username = "", userprofile = "";

  User? user = FirebaseAuth.instance.currentUser;
  FeildController feildcontroller = FeildController();
  final getFirestore = FirebaseFirestore.instance.collection("Userdetails");

  Future<void> getuserdata() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userdoc = await getFirestore.doc(id).get();
    if (userdoc.exists) {
      setState(() {
        username = userdoc["Name"] ?? "Unknown User";
        userprofile = userdoc["ImageURL"] ?? Icon(Icons.person);
      });
      print(userdoc);
    }
  }

  @override
  void initState() {
    getuserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            arrowColor: Colors.green,
            accountName: Text(username),
            accountEmail: Text(user!.email.toString(), style: Drawertextstyle),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.red,
              backgroundImage:
                  userprofile.isNotEmpty ? NetworkImage(userprofile) : null,
              child: userprofile.isEmpty ? Icon(Icons.person) : null,
            ),
          ),
          GestureDetector(
            onTap: () {
              final route = MaterialPageRoute(
                builder: (context) => Accountdetails(),
              );
              Navigator.push(context, route);
            },
            child: ListTile(
              leading: Icon(Icons.manage_accounts),
              title: Text(
                "Account",
                style: Draweroptiontextstyle,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final route = MaterialPageRoute(
                builder: (context) => FeedBack(),
              );
              Navigator.push(context, route);
            },
            child: ListTile(
              leading: Icon(Icons.feedback),
              title: Text(
                "Feedback",
                style: Draweroptiontextstyle,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final route = MaterialPageRoute(
                builder: (context) => OderHistory(),
              );
              Navigator.push(context, route);
            },
            child: ListTile(
              leading: Icon(Icons.history),
              title: Text(
                "Oder History",
                style: Draweroptiontextstyle,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final route = MaterialPageRoute(
                builder: (context) => Rateatheapp(),
              );
              Navigator.push(context, route);
            },
            child: ListTile(
              leading: Icon(Icons.rate_review),
              title: Text(
                "Rate the App",
                style: Draweroptiontextstyle,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green)),
            child: Text(
              "Sign Out",
              style: cartbuttonstyle,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          )
        ],
      ),
    );
  }
}
