import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/api_url.dart';
import 'dart:convert';

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class Product {
  final String name, imageUrl, description, category, price;
  Product(
      this.name, this.imageUrl, this.description, this.category, this.price);
}

class _ProductPageState extends State<ProductPage> {
  Future getProductDetails() async {
    final args = ModalRoute.of(context).settings.arguments;
    var response = await http.get(Uri.parse(ApiUrl.get_product_by_id + args));
    var jsonData = jsonDecode(response.body);
    List<Product> details = [];

    for (var u in jsonData) {
      Product detail = Product(
        u["name"],
        u["imageUrl"],
        u["description"],
        u["category"],
        u["price"],
      );
      details.add(detail);
    }
    print(jsonData);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProductDetails(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text("Loading..."),
            ),
          );
        } else
          return Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Card(
                    child: Image.asset(
                      "images/product_images/iphone13.png",
                      height: 250,
                      width: 250,
                      fit: BoxFit.contain,
                    ),
                    //elevation: 18.0,
                    shape: RoundedRectangleBorder(),
                    shadowColor: Colors.black,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("iPhone 13 Pro Max",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w700)),
                  Text("\n\$1500.00"),
                  Text("\nQuantity: 1"),
                  Text("\n\nOrder in next 1 Hour and get it by tomorrow\n\n"),
                  Row(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {},
                    child: Text('Add to Cart'),
                  )
                ],
              ),
              VerticalDivider(
                color: Colors.black,
                thickness: 2,
                width: 20,
                indent: 200,
                endIndent: 200,
              ),
              Container(
                  height: 250, child: VerticalDivider(color: Colors.grey)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  Text(
                      "\n\nAs part of our efforts to reach our environmental goals, \niPhone 13 Pro and iPhone 13 Pro Max do not include \na power adapter or EarPods. Included in the box is a USB‑C \nto Lightning Cable that supports fast charging and is \ncompatible with USB‑C power adapters and computer ports."),
                  Text(
                      "\n\nDimensions: 160.8 x 78.1 x 7.7 mm\nWeight: 240 g (8.47 oz)")
                ],
              )
            ],
          ));
      },
    );
  }
}
