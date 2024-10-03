import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:groceryapp/Strip/Strippayment.dart';
import 'package:groceryapp/style/style.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class Oder extends StatefulWidget {
  Oder({super.key, required this.Totalpize});
  final double Totalpize;

  @override
  State<Oder> createState() => _OrderState();
}

class _OrderState extends State<Oder> {
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  Map<String, dynamic>? paymentIntentdata = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Confrim Order",
          style: Titletextstyle,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Your Total Bill of Shopping",
              style: Odertextstyle,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "${widget.Totalpize} USD",
              style: Oderprizestyle2,
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green)),
              onPressed: () async {
                await makepayment();
              },
              icon: Icon(
                Icons.payment,
                color: Colors.white,
              ),
              label: Text(
                "Pay ${widget.Totalpize} USD",
                style: Oderprizestyle1,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> makepayment() async {
    try {
      paymentIntentdata =
          await Strippayment().creatpaymentintent("130", "SEK", context);
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            setupIntentClientSecret: "Secretkey",
            paymentIntentClientSecret: paymentIntentdata!["client_secret"],
            customFlow: true,
            merchantDisplayName: "M.Abdulwahab",
          ))
          .then((value) {});
      Strippayment().Displaypaymentsheet(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Payment Exception: ${e.toString()}")));
    }
  }
}
