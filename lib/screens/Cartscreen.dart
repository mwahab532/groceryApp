import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:groceryapp/firebase/Addorder.dart';
import 'package:groceryapp/provider/cartitemsprovider.dart';
import 'package:groceryapp/style/style.dart';
import 'package:provider/provider.dart';

class Cartscreen extends StatefulWidget {
  Cartscreen({super.key});
  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  final Firestore = FirebaseFirestore.instance.collection("UserOder");
  Addorderclass orderclass = Addorderclass();

  @override
  Widget build(BuildContext context) {
    final cartprovider = Provider.of<cartitemsprovider>(context);
    double totalprice = cartprovider.totalorderPrice;
    // final submiteorderprvider = Provider.of<Submitorders>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Cart", style: Titletextstyle),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: cartprovider.cartitems.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.grey,
                            size: 70,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "No item in cart",
                            style: emptycartmessagestyle,
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: cartprovider.cartitems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      cartprovider.remove(
                                          cartprovider.cartitems[index],
                                          context);
                                    },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                    borderRadius: BorderRadius.circular(120),
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  leading: Image.network(cartprovider
                                      .cartitems[index].ItemimgeUrl),
                                  title: Text(
                                    cartprovider.cartitems[index].Itemname,
                                    style: productnametextstyle,
                                  ),
                                  subtitle: Text(
                                    "${cartprovider.cartitems[index].Itempize.toString()}USD",
                                    style: productnametextstyle,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          cartprovider.cartitems[index]
                                              .decrementQuantity();
                                          setState(() {});
                                        },
                                      ),
                                      Text(
                                          "${cartprovider.cartitems[index].Quantity}"),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          cartprovider.cartitems[index]
                                              .incrementQuantity();
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: totaltextstyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${totalprice.toStringAsFixed(2)} USD",
                            style: totalprizestyle,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.green)),
                        onPressed: () async {
                          // ignore: unused_local_variable
                          await cartprovider
                              .addorder(orderclass, totalprice, context)
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                    "Successfully Placed your Order! please pay billing to confrim your order")));
                          });
                        },
                        child: Text('Checkout', style: cartbuttonstyle),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (cartprovider.isUploading)
            Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
        ],
      ),
    );
  }
}
