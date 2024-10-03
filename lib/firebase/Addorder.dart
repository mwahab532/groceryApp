import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/provider/cartitemsprovider.dart';
import 'package:provider/provider.dart';

class Addorderclass{
    final Firestore = FirebaseFirestore.instance.collection("UserOder");
  Future<void>AddOderrdetails(BuildContext context) async {
    final cartprovider = Provider.of<cartitemsprovider>(context, listen: false);
    try {
      var totalOderPrice = cartprovider.cartitems.fold(0.0, (total, item) {
        return total + item.Itempize * item.Quantity;
      });
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userOrderRef = Firestore.doc(userId);
      Map<String, dynamic> newOrder = {
        'oderlist': cartprovider.cartitems.map((item) {
          return {
            'ItemName': item.Itemname,
            'ItemImageUrl': item.ItemimgeUrl,
            'ItemPrice': item.Itempize,
            'ItemQuantity': item.Quantity,
          };
        }).toList(),
        'TotalPrice': totalOderPrice,
        'odertime': DateTime.now(),
      };
      await userOrderRef.update({
        'orders': FieldValue.arrayUnion([newOrder]),
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Your Order is Successfully accepted.please pay billing to confrirm your order")));
        cartprovider.clearcart(); 
      }).catchError((e) async {
        await userOrderRef.set({
          'userId': userId,
          'orders': [newOrder],
        });
       
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to accept your order.")));
    }
  }
}