import 'package:flutter/material.dart';
import 'package:groceryapp/firebase/Auth/Authservices.dart';
import 'package:groceryapp/controllers/Feildcontroller.dart';
import 'package:groceryapp/screens/Register.dart';
import 'package:groceryapp/style/style.dart';
import 'package:groceryapp/widgets/loginfeilds.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  bool isvisble = false;
  Logincontroller logincontroller = Logincontroller();
  final Authservices _authservices = Authservices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.green,
      extendBody: true,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Loginwidget(),
          ],
        ),
      ),
    );
  }

  Widget Loginwidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Sign to \n Grocery App! ",
                style: Logintextstyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    loginfeild(
                        validator: (text) {
                          if (text.isEmpty) {
                            return "Email can't be Empty";
                          }
                          return null;
                        },
                        hinttxt: "Email or username",
                        isobscure: false,
                        controller: logincontroller.emailcontroller),
                    SizedBox(
                      height: 15,
                    ),
                    loginfeild(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Password can't be Empty";
                        }
                        return null;
                      },
                      hinttxt: "Password",
                      isobscure: !isvisble,
                      controller: logincontroller.passwordcontroller,
                      iconbutton: IconButton(
                        onPressed: () {
                          setState(() {
                            isvisble = !isvisble;
                          });
                        },
                        icon: isvisble
                            ? Icon(Icons.visibility, color: Colors.white)
                            : Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        RoundedLoadingButton(
                          color: Colors.black,
                          controller: logincontroller.btnController,
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _authservices.SignInUserWithEmailAndPassword(
                                  email: logincontroller.emailcontroller.text
                                      .trim(),
                                  password: logincontroller
                                      .passwordcontroller.text
                                      .trim(),
                                  context: context);
                            }
                            logincontroller.emailcontroller.clear();
                            logincontroller.passwordcontroller.clear();
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RoundedLoadingButton(
                          color: Colors.black,
                          controller: logincontroller.loadingButtonController,
                          onPressed: () {
                            final route = MaterialPageRoute(
                              builder: (context) => Register(),
                            );
                            Navigator.push(context, route);
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
