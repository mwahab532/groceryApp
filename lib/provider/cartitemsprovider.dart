import 'package:flutter/material.dart';
import 'package:groceryapp/data/groceryitemsdata.dart';
import 'package:groceryapp/firebase/Addorder.dart';
import 'package:groceryapp/screens/Confirmoder.dart';

class cartitemsprovider extends ChangeNotifier {
  List<Item> _cartitems = [];
  int _counter = 0;
  bool isUploading = false;
  //getter
  int get counter => _counter;
  List<Item> get cartitems => _cartitems;
  void incrementcounter() {
    _counter++;
    notifyListeners();
  }

  void decrementcounter() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }

  void add(Item item, BuildContext context) {
    if (_cartitems.contains(item)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Item is already in cart")));
    } else {
      _cartitems.add(item);
      incrementcounter();
      notifyListeners();
    }
  }

  void remove(Item item, BuildContext context) {
    _cartitems.remove(item);
    decrementcounter();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Item is remove successfully form  cart")));
    notifyListeners();
  }

  double get totalorderPrice {
    return _cartitems.fold(0.0, (total, item) {
      return total + item.Itempize * item.Quantity;
    });
  }

  Future<void>addorder(
      Addorderclass orderclass, double totalPrice, BuildContext context) async {
    if (_cartitems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("No items in cart yet for order!Please add items")));
    } else {
      isUploading = true;
      notifyListeners();
      await orderclass.AddOderrdetails(context);
      isUploading = false;
      notifyListeners();
      final route =
          MaterialPageRoute(builder: (context) => Oder(Totalpize: totalPrice));
      Navigator.push(context, route);
      clearcart();
    }
  }

  void clearcart() {
    _cartitems.clear();
    _counter = 0;
    notifyListeners();
  }
}
