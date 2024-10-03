import 'package:flutter/material.dart';
import 'package:groceryapp/controllers/Feildcontroller.dart';
import 'package:groceryapp/data/groceryitemsdata.dart';
import 'package:groceryapp/provider/cartitemsprovider.dart';
import 'package:groceryapp/screens/Cartscreen.dart';
import 'package:groceryapp/screens/drawer.dart';
import 'package:groceryapp/style/style.dart';
import 'package:groceryapp/widgets/customfeild.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GroceryItems groceryItems = GroceryItems();
  FeildController feildcontroller = FeildController();
  List<Item> fillterItems = [];
  List<String> sortOptions = [
    'Alphabetically [A-Z]',
    'Price high to low',
    'Price Low to high',
  ];
  String selectedValue = 'Alphabetically [A-Z]';

  void searchItems(String input) {
    setState(() {
      if (input != Null && input.isNotEmpty) {
        fillterItems = groceryItems.GroceryItemsObjList.where((Items) =>
            Items.Itemname.toLowerCase()
                .toLowerCase()
                .contains(input.toLowerCase())).toList();
      } else {
        fillterItems = groceryItems.GroceryItemsObjList;
      }
    });
  }

  void sortdata() {
    setState(() {
      switch (selectedValue) {
        case 'Alphabetically [A-Z]':
          fillterItems.sort((a, b) => a.Itemname.compareTo(b.Itemname));
          break;
        case 'Price high to low':
          fillterItems.sort((a, b) => b.Itempize.compareTo(a.Itempize));
          break;
        case 'Price Low to high':
          fillterItems.sort((a, b) => a.Itempize.compareTo(b.Itempize));
        default:
          fillterItems = groceryItems.GroceryItemsObjList;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fillterItems = groceryItems.GroceryItemsObjList;
    feildcontroller.searchcontroller.addListener(() {
      searchItems(feildcontroller.searchcontroller.text);
    });
  }

  @override
  void dispose() {
    feildcontroller.searchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartprovider = Provider.of<cartitemsprovider>(context);
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              "Grocery App",
              style: Titletextstyle,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.green,
                size: 25,
              ),
              onPressed: () {
                final route = MaterialPageRoute(
                  builder: (context) => Cartscreen(),
                );
                Navigator.push(context, route);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 8),
              child: Text(
                "${cartprovider.counter}",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
              child: CustomSearchField(
                Onchange: (input) {
                  searchItems(input);
                },
                fillColor: Colors.white,
                controller: feildcontroller.searchcontroller,
                hintname: "Search Items...",
                hintstyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Fillter",
                      style: filltertextstyle,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      bottomsheet(context);
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: fillterItems.isEmpty
                    ? Center(
                        child: Text(
                          'No items found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 10),
                        itemCount: fillterItems.length,
                        itemBuilder: (context, index) {
                          return Productcontainer(context, index, fillterItems);
                        },
                      ),
              ),
            ),
          ],
        ),
        drawer: Mydrawer());
  }

  Widget Productcontainer(
      BuildContext context, int index, List<Item> Fillteritems) {
    final cartprovider = Provider.of<cartitemsprovider>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.green, width: 3),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            child: Image.network(
              fillterItems[index].ItemimgeUrl,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
            ),
          ),
          Spacer(),
          Container(
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          fillterItems[index].Itemname,
                          style: productnametextstyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          "${fillterItems[index].Itempize.toString()} USD",
                          style: productnametextstyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  child: Text(
                    "Add to cart",
                    style: cartbuttonstyle,
                  ),
                  onPressed: () {
                    cartprovider.add(fillterItems[index], context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomsheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 220,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 45,
                width: double.infinity,
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Sort by: ${selectedValue}",
                    style: sorttextstyle,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sortOptions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.sort),
                      title:
                          Text(sortOptions[index], style: bottomsheettextstyle),
                      onTap: () {
                        setState(
                          () {
                            selectedValue = sortOptions[index];
                            sortdata();
                          },
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
    return Container();
  }
}
