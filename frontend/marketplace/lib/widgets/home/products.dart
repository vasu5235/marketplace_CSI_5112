import 'package:flutter/cupertino.dart';
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
    print(jsonData);
    return jsonData;
  }

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
                  prod_quantity: snapshot.data[index]['quantity'],
                  prod_description: snapshot.data[index]['description'],
                  cartController: cartController,
                );
              });
        }
      },
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
  final CartProductsController cartController;
  Single_prod(
      {this.prod_id,
      this.prod_name,
      this.prod_picture,
      this.prod_price,
      this.cartController,
      this.prod_quantity,
      this.prod_description});

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

              //Navigator.pushNamed(context, RouteNames.product);
              showDialog(context: context, builder: (BuildContext context) => PopupDialog(context),);
            //  Navigator.pushNamed(context, RouteNames.product,
             //     arguments: prod_id);

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
                            prod_name, prod_picture, prod_price, prod_quantity);
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      elevation: 50,
      title: Text(prod_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
      content: new Column(

        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Divider(color: Colors.black,),
          SizedBox(
            height: 32,
          ),
          Text("Price: \$ ${prod_price.toString()}", style: TextStyle( fontSize: 20) ),
          //Text(prod_price.toString()),
          SizedBox(
            height: 16,
          ),
          Flexible(
              child: Text(prod_description, style: TextStyle( fontSize: 20)),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.white,
          color: Colors.red,
          child: const Text('Close'),
        ),
        SizedBox(
          height:64,
        ),

      ],
    );
  }
}
