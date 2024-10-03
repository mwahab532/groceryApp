class Item {
  String Itemname;
  var ItemimgeUrl;
  int Itempize;
  int Quantity;
  Item({
    required this.Itemname,
    required this.ItemimgeUrl,
    required this.Itempize,
    required this.Quantity,
  });
  int incrementQuantity() {
    Quantity++;
    return Quantity;
  }

  int decrementQuantity() {
    if (Quantity > 0) {
      Quantity--;
    }
    return Quantity;
  }
}

class GroceryItems {
  List<Item> GroceryItemsObjList = [
    Item(
      Itemname: "Apple",
      ItemimgeUrl:
          "https://media.istockphoto.com/id/184276818/photo/red-apple.jpg?s=612x612&w=0&k=20&c=NvO-bLsG0DJ_7Ii8SSVoKLurzjmV0Qi4eGfn6nW3l5w=",
      Itempize: 200,
      Quantity: 0,
    ),
    Item(
      Itemname: "Banana",
      ItemimgeUrl:
          "https://static9.depositphotos.com/1642482/1149/i/380/depositphotos_11490583-stock-photo-bananas.jpg",
      Itempize: 150,
      Quantity: 0,
    ),
    Item(
      Itemname: "Milk",
      ItemimgeUrl:
          "https://atlas-content-cdn.pixelsquid.com/stock-images/milk-carton-qvnWRx8-600.jpg",
      Itempize: 300,
      Quantity: 0,
    ),
    Item(
        Itemname: "Yogurt",
        ItemimgeUrl:
            "https://froneri.ph/wp-content/uploads/2020/11/nestle-creamy-yogurt-500g.png",
        Itempize: 400,
        Quantity: 0),
    Item(
      Itemname: "Butter",
      ItemimgeUrl: "https://pngimg.com/uploads/butter/butter_PNG12.png",
      Itempize: 400,
      Quantity: 0,
    ),
    Item(
      Itemname: "Eggs",
      ItemimgeUrl:
          "https://static.vecteezy.com/system/resources/thumbnails/035/642/273/small/ai-generated-egg-in-carton-free-png.png",
      Itempize: 160,
      Quantity: 0,
    ),
    Item(
      Itemname: "vegetabl",
      ItemimgeUrl:
          "https://clipart-library.com/new_gallery/27-277606_vegetable-png-chesterbrook-vegetable-hd.png",
      Itempize: 220,
      Quantity: 0,
    ),
    Item(
      Itemname: "Ketchup",
      ItemimgeUrl:
          "https://www.roetell.com/wp-content/uploads/2023/03/Hot-Sauce-Bottle-Design.jpg",
      Itempize: 290,
      Quantity: 0,
    ),
    Item(
      Itemname: "Meat",
      ItemimgeUrl:
          "https://d12oja0ew7x0i8.cloudfront.net/images/news/ImageForNews_57171_16359482503672646.jpg",
      Itempize: 450,
      Quantity: 0,
    ),
    Item(
      Itemname: "Chips",
      ItemimgeUrl:
          "https://cdn.rationatmydoor.com/wp-content/uploads/2019/04/lays-assorted.jpg",
      Itempize: 50,
      Quantity: 0,
    ),
    Item(
      Itemname: "chocolates",
      ItemimgeUrl:
          "https://www.alubaidiya.pk/wp-content/uploads/2019/01/Nutty-Chocolate-Gift-Hampers.jpg",
      Itempize: 500,
      Quantity: 0,
    ),
    Item(
      Itemname: "Bread",
      ItemimgeUrl:
          "https://images.deliveryhero.io/image/darsktores-pk/894559000600.JPG?height=480",
      Itempize: 210,
      Quantity: 0,
    ),
    Item(
      Itemname: "Pasta",
      ItemimgeUrl:
          "https://res.cloudinary.com/nassau-candy/image/upload/c_fit,w_1000,h_1000,f_auto/963664.jpg",
      Itempize: 610,
      Quantity: 0,
    ),
    Item(
      Itemname: "Rice",
      ItemimgeUrl:
          "https://www.pakpackages.com/uploadimages/general_images_68.jpg",
      Itempize: 900,
      Quantity: 0,
    ),
    Item(
      Itemname: "Shampo",
      ItemimgeUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAdQu57HdA6vruocqVhRPwFdZDO_WcPIz1nw&s",
      Itempize: 650,
      Quantity: 0,
    ),
    Item(
      Itemname: "TouthPast",
      ItemimgeUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT2TVF3WoWcpXc8FMGRfOalpmcd8um0toVvA&s",
      Itempize: 170,
      Quantity: 0,
    ),
  ];
}
 //https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAdQu57HdA6vruocqVhRPwFdZDO_WcPIz1nw&s