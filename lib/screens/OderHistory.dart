import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groceryapp/style/style.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class OderHistory extends StatelessWidget {
  OderHistory({super.key});
  String userid = FirebaseAuth.instance.currentUser!.uid;
   
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd/MM/yyyy – kk:mm')
        .format(dateTime); // Format the date and time
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders',style: Ordertextstyle,),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('UserOder')
              .doc(userid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.data() == null) {
              return Center(child: Text('No orders found.'));
            }

            var orderData = snapshot.data!.data() as Map<String, dynamic>;
            var orders = orderData['orders'] as List<dynamic>;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                var items = order['oderlist'] as List<dynamic>;
                Timestamp orderTime = order['odertime'];
                return Card(
                  child: ExpansionTile(
                    title: Text('Order ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price: ${order['TotalPrice']} USD',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Order Time: ${formatTimestamp(orderTime)}')
                      ],
                    ),
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, itemIndex) {
                          var item = items[itemIndex];
                          return GridTile(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  child: Image.network(
                                    item['ItemImageUrl'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  item['ItemName'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                ),
                                Text(
                                  'Quantity:${item['ItemQuantity']}',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text('Price:${item['ItemPrice']} USD'),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
