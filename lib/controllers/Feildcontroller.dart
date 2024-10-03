import 'package:flutter/material.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class FeildController {
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController Dateofbrithcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController Phonecontroller = TextEditingController();
  TextEditingController Countrycontroller = TextEditingController();
  TextEditingController Citycontroller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();
}

class Logincontroller {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();
}

class Registercontroller {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
}

class Displaycontroller {
  TextEditingController Displaynamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController Phonecontroller = TextEditingController();
  TextEditingController Countrycontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();
  TextEditingController Citycontroller = TextEditingController();
  TextEditingController feedbackcontroller = TextEditingController();
  final RoundedLoadingButtonController feedbackbtnController =
      RoundedLoadingButtonController();
}
