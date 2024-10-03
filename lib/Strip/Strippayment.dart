import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:groceryapp/keys/keys.dart';
import 'package:http/http.dart' as http;

class Strippayment {
  Map<String, dynamic>? paymentIntentdata = {};
  // Future<void> makepayment(BuildContext context) async {
  //   try {
  //     paymentIntentdata = await creatpaymentintent("150", "SEK", context);
  //     await Stripe.instance
  //         .initPaymentSheet(
  //             paymentSheetParameters: SetupPaymentSheetParameters(
  //           setupIntentClientSecret: "Secretkey",
  //           paymentIntentClientSecret: paymentIntentdata!["client_secret"],
  //           customFlow: true,
  //           merchantDisplayName: "M.Abdulwahab",
  //         ))
  //         .then((value) {});
  //     Displaypaymentsheet(context);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text("Payment Exception: ${e.toString()}")));
  //   }
  // }

  Displaypaymentsheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Payment is Successfull")));
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
                "Payment Cancelled!Please pay the amount for confrimation of order")));
      });
    } on StripeException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Strip Exception:${e.toString()}")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("User Charging :${e.toString()}")));
    }
  }

  creatpaymentintent(
      String amount, String currency, BuildContext context) async {
    try {
      Map<String, dynamic> body = {
        "amount": calculateamount(amount),
        "currency": currency,
        "payment_method_types[]": 'card'
      };
      var responce = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          "Authorization": "Bearer $Secretkey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      return jsonDecode(responce.body);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error in strip: ${e.toString()}")));
    }
  }

  calculateamount(String amount) {
    final a = int.parse(amount) * 100;
    return a.toString();
  }
}
