import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/firebase/Auth/Registerservices.dart';
import 'package:groceryapp/controllers/Feildcontroller.dart';
import 'package:groceryapp/screens/userInfo.dart';
import 'package:groceryapp/style/style.dart';
import 'package:groceryapp/widgets/Registerfeilds.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  bool isvisible = false;
  Registercontroller registercontroller = Registercontroller();
  final Registerservices _registerservices = Registerservices();

  Future<bool> cheakinternetconnection() async {
    var connectivityresults = await Connectivity().checkConnectivity();
    if (connectivityresults == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            register(),
          ],
        ),
      ),
    );
  }

  Widget register() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Sign Up \n Grocery App!",
              style: Registertextstyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 100 ,
            ),
            SizedBox(
              height: 50,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Registerfeilds(
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Email can't be Empty";
                      }
                      return null;
                    },
                    hinttxt: "Email or username",
                    isobscure: false,
                    controller: registercontroller.emailcontroller,
                    txtsty: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Registerfeilds(
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Email can't be Empty";
                      }
                      return null;
                    },
                    hinttxt: "Password",
                    isobscure: isvisible,
                    controller: registercontroller.passwordcontroller,
                    txtsty: TextStyle(color: Colors.white),
                    iconbutton: IconButton(
                      onPressed: () {
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                      icon: isvisible
                          ? Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      RoundedLoadingButton(
                        color: Colors.black,
                        controller: registercontroller.btnController,
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            bool cheakconnection =
                                await cheakinternetconnection();
                            if (!cheakconnection) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      "No internet connection!Please try again")));
                              registercontroller.btnController.reset();
                              return;
                            }

                            _registerservices
                                .createUserWithEmailAndPassword(
                                    email: registercontroller
                                        .emailcontroller.text
                                        .trim(),
                                    password: registercontroller
                                        .passwordcontroller.text
                                        .trim(),
                                    context: context)
                                .then((_) {
                              final route = MaterialPageRoute(
                                builder: (context) => UserInfoPage(),
                              );
                              Navigator.push(context, route);
                            });
                            registercontroller.emailcontroller.clear();
                            registercontroller.passwordcontroller.clear();
                          }
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
