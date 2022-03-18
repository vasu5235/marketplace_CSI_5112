import 'package:flutter/material.dart';
import 'package:marketplace/constants/route_names.dart';
import 'package:marketplace/utils/cart_products_controller.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/api_url.dart';

class SearchResultsPage extends StatefulWidget {
  final String _searchTextValue;

  const SearchResultsPage(this._searchTextValue, {Key key}) : super(key: key);

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  Future searchProduct() async {
    var response = await http.get(ApiUrl.search_by_product_name +
        widget._searchTextValue.toString().toLowerCase());
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    return jsonData;
    //print(total_price[i - 1]);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: PageTitles.searchResults,
      body: FutureBuilder(
        future: searchProduct(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("Loading..."),
              ),
            );
          } else if (snapshot.data.length == 0) {
            return Container(
              child: Center(
                child: Text("Not Found"),
              ),
            );
          } else {
            CartProductsController cartController =
                new CartProductsController();

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
                    prod_quantity: snapshot.data[index]['quantity'],
                    prod_description: snapshot.data[index]['description'],
                    prod_category: snapshot.data[index]['category'],
                    cartController: cartController,
                  );
                });
          }
        },
      ),
    );
  }
}

class Single_prod extends StatelessWidget {
  final prod_id;
  final prod_name;
  final prod_picture;
  final prod_price;
  final prod_quantity;
  final prod_description;
  final prod_category;
  final CartProductsController cartController;
  Single_prod(
      {this.prod_id,
      this.prod_name,
      this.prod_picture,
      this.prod_price,
      this.cartController,
      this.prod_quantity,
      this.prod_description,
      this.prod_category});

  @override
  Widget build(BuildContext context) {
    //print("description: " + prod_description.toString());
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
                      onPressed: () async {
                        await cartController.addProductToCart(
                            prod_id,
                            prod_name,
                            prod_picture,
                            prod_price,
                            prod_quantity,
                            prod_description,
                            prod_category);
                        AlertDialog addToCartSuccess = AlertDialog(
                          // Retrieve the text the that user has entered by using the
                          // TextEditingController.
                          content: Text("Product added to cart!"),
                        );

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return addToCartSuccess;
                          },
                        );
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
