import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import '../widgets/app_scaffold.dart';
import '../../constants/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:marketplace/utils/cart_products_controller.dart';
//import 'package:marketplace/constants/route_names.dart';

class CategoryFilteredProductsPage extends StatefulWidget {
  final String _categoryName;

  const CategoryFilteredProductsPage(this._categoryName, {Key key})
      : super(key: key);

  @override
  State<CategoryFilteredProductsPage> createState() =>
      _CategoryFilteredProductsPageState();
}

class _CategoryFilteredProductsPageState
    extends State<CategoryFilteredProductsPage> {
  var session = FlutterSession();
  var _userIsMerchant = false;

  Future<dynamic> _loadSession() async {
    _userIsMerchant = await session.get("user_is_merchant");
  }

  Future getProductList() async {
    var response = await http.get(Uri.parse(
        ApiUrl.get_product_by_category + widget._categoryName.toLowerCase()));
    var jsonData = jsonDecode(response.body);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: "${widget._categoryName}",
      body: Column(children: <Widget>[
        FutureBuilder(
            future: _loadSession(),
            builder: (context, snapshot) {
              if (_userIsMerchant) {
                return TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  // textColor: Colors.white,
                  // color: Colors.red,
                  child: const Text('Close'),
                );
              } else {
                return SizedBox();
              }
            }),
        Expanded(
            child: FutureBuilder(
          future: getProductList(),
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
                  child: Text("No products to display in this category"),
                ),
              );
            } else {
              CartProductsController cartController =
                  new CartProductsController();
              //print(snapshot.data);
              return GridView.builder(
                  physics: ScrollPhysics(), // to disable GridView's scrolling
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 10),
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
        ))
      ]),

      //),
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
              // Navigator.pushNamed(context, RouteNames.product,
              //     arguments: prod_id);
              showDialog(
                context: context,
                builder: (BuildContext context) => PopupDialog(context),
              );
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

  Widget PopupDialog(BuildContext context) {
    return new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 50,
      title: Text(
        prod_name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 32,
          ),
          Text("Price: \$ ${prod_price.toString()}",
              style: TextStyle(fontSize: 20)),
          //Text(prod_price.toString()),
          SizedBox(
            height: 16,
          ),
          Flexible(
            child: Text(prod_description, style: TextStyle(fontSize: 20)),
          )
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        SizedBox(
          height: 64,
        ),
      ],
    );
  }
}
