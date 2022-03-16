import 'package:flutter/material.dart';
import 'package:marketplace/constants/route_names.dart';
import 'package:http/http.dart' as http;
import 'package:marketplace/utils/cart_products_controller.dart';
import '../../constants/api_url.dart';
import 'dart:convert';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  Future getProductList() async {
    var response = await http.get(Uri.parse(ApiUrl.get_recent_product));
    var jsonData = jsonDecode(response.body);
    return jsonData;
  }

  // var product_list = [
  //   {
  //     "name": "Test-1",
  //     "picture": "images/recent_images/01.jpeg",
  //     "old_price": 100,
  //     "price": 80,
  //   },
  //   {
  //     "name": "Test-2",
  //     "picture": "images/recent_images/02.jpeg",
  //     "old_price": 100,
  //     "price": 80,
  //   },
  //   {
  //     "name": "Test-3",
  //     "picture": "images/recent_images/03.jpeg",
  //     "old_price": 100,
  //     "price": 80,
  //   },
  //   {
  //     "name": "Test-4",
  //     "picture": "images/recent_images/04.jpeg",
  //     "old_price": 100,
  //     "price": 80,
  //   },
  //   {
  //     "name": "Test-5",
  //     "picture": "images/recent_images/05.jpeg",
  //     "old_price": 100,
  //     "price": 80,
  //   },
  //   {
  //     "name": "Test-6",
  //     "picture": "images/recent_images/06.jpeg",
  //     "old_price": 100,
  //     "price": 80,
  //   }
  // ];

  //Grid View of products using Category() to build Product ListTiles
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProductList(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text("Loading..."),
            ),
          );
        } else {
          CartProductsController cartController = new CartProductsController();
          return GridView.builder(
              physics: ScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 50),
              itemBuilder: (context, index) {
                return Single_prod(
                  prod_id: snapshot.data[index]['id'],
                  prod_name: snapshot.data[index]['name'],
                  prod_picture: snapshot.data[index]['imageUrl'],
                  prod_price: snapshot.data[index]['price'],
                  cartController: cartController,
                );
              });
        }
      },
    );
  }
  // Widget build(BuildContext context) {
  //   return GridView.builder(
  //       physics: ScrollPhysics(), // to disable GridView's scrolling
  //       shrinkWrap: true,
  //       itemCount: product_list.length,
  //       gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 3, crossAxisSpacing: 50),
  //       itemBuilder: (BuildContext context, int index) {
  //         return Single_prod(
  //           prod_name: product_list[index]['name'],
  //           prod_picture: product_list[index]['picture'],
  //           prod_old_price: product_list[index]['old_price'],
  //           prod_price: product_list[index]['price'],
  //         );
  //       });
  // }
}

class Single_prod extends StatelessWidget {
  final prod_id;
  final prod_name;
  final prod_picture;
  final prod_price;
  final CartProductsController cartController;
  Single_prod(
      {this.prod_id,
      this.prod_name,
      this.prod_picture,
      this.prod_price,
      this.cartController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Hero(
          tag: prod_name,
          child: Material(
              child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.product,
                  arguments: prod_id);
            },
            child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(prod_name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0)),
                    title: Text(
                      "\$$prod_price",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.add_box_rounded),
                      onPressed: () {
                        cartController.addProductToCart(
                            prod_name, prod_picture, prod_price);
                      },
                    ),
                  ),
                ),
                child: Image.asset(
                  prod_picture,
                  fit: BoxFit.cover,
                )),
          ))),
    );
  }
}
