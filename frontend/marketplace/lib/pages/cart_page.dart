import 'package:flutter/material.dart';
import 'package:marketplace/utils/cart_products_controller.dart';
import 'dart:math';


import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';
import 'cart_products.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_url.dart';
import 'package:flutter_session/flutter_session.dart';
import 'dart:convert';
import 'package:marketplace/constants/route_names.dart';
import 'package:uuid/uuid.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: PageTitles.cart,
      body: Column(
        children: <Widget>[
          // Layout: Row: Text (Row: Total+Checkout) -> Row: cartProducts + Summary View
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20),
                child: Text(
                  'Almost there!',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.023,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        label: Text('Checkout'),
                        icon: Icon(Icons.shopping_bag_rounded),
                        onPressed: () async {
                          var _productList =
                              await CartProductsController().getProducts();
                          print(_productList);
                          // var email = emailTextFieldController.text;
                          // var password = passwordFieldController.text;
                          // var name = nameFieldController.text;
                          // int randomId = Random().nextInt(99999);

                          // Map bodyData = {
                          //   "id": randomId,
                          //   "name": name,
                          //   "email": email,
                          //   "password": password,
                          //   "isMerchant": false
                          // };

                          var body = json.encode(_productList);
                          print(body);

                          // print("email: " + emailTextFieldController.text);
                          // print("password: " + passwordFieldController.text);
                          var session = FlutterSession();
                          var randomId =
                              await Random().nextInt(99999999).toString();
                          print(randomId);
                          //var uuid = Uuid();
                          var _userId = '0';
                          _userId = await session.get("user_id").toString();
                          print(_userId);
                          //print(_userId);

                          // if (_userId == null) {
                          //   _userId = 0;
                          // }
                          var orderid = _userId + '-' + randomId;
                          print(orderid);
                          String uri = ApiUrl.checkout + orderid.toString();

                          //final url = Uri.encodeFull("${uri}");
                          //print(url);
                          print("===URL===" + uri);

                          var response = await http.post(uri,
                              headers: {
                                'Content-Type': 'application/json',
                                'accept': 'text/plain'
                              },
                              body: body);
                          print("Response\n" + response.body);

                          if (response.body == "true") {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Success: Order Placed'),
                                      content: Text(''),
                                      actions: [
                                        TextButton(
                                            child: Text('Ok'),
                                            onPressed: () => {
                                                  Navigator.pushNamed(
                                                      context, RouteNames.cart)
                                                  //Navigator.pop(context)
                                                  //setState(() {})
                                                })
                                      ],
                                    ));

                            // AlertDialog checkoutSuccess = AlertDialog(
                            //   // Retrieve the text the that user has entered by using the
                            //   // TextEditingController.

                            //   content: Text("Success!"),
                            // );

                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     //Future.delayed(Duration(seconds: 2), onDismiss);
                            //     return checkoutSuccess;
                            //   },
                            // );
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Failed'),
                                      content: Text(''),
                                      actions: [
                                        TextButton(
                                            child: Text('Ok'),
                                            onPressed: () => {
                                                  // Navigator.pushNamed(
                                                  //     context, RouteNames.cart)
                                                  Navigator.pop(context)
                                                  //setState(() {})
                                                })
                                      ],
                                    ));
                            // AlertDialog checkoutFail = AlertDialog(
                            //   // Retrieve the text the that user has entered by using the
                            //   // TextEditingController.
                            //   content: Text("Oops! Failed"),
                            // );

                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return checkoutFail;
                            //   },
                            // );
                          }
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                      ))
                ],
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: CartProducts(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Container(
                    // decoration: BoxDecoration(color: Colors.yellow),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.0),
                          Text(
                            "Summary",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Order Value: \$1300",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Tax: \$200",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Total: \$1500",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 40),
                          Center(
                              // padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton.icon(
                            label: Text('Invoice'),
                            icon: Icon(Icons.download),
                            onPressed: () async {
                              List<Map<String, Object>> currentCartProducts =
                                  CartProductsController().getProducts();

                              List<List<Object>> productInfoSubset = <List>[];
                              double cartTotal = 0;

                              for (var productInfo in currentCartProducts) {
                                List<String> temp = [];

                                //ensure correct insertion order with table headers
                                temp.add(productInfo["name"]);
                                temp.add(productInfo["price"].toString());
                                temp.add(productInfo["quantity"].toString());

                                double tempPrice =
                                    productInfo["price"] as double;
                                int tempQuantity =
                                    productInfo["quantity"] as int;

                                cartTotal =
                                    cartTotal + (tempPrice * tempQuantity);

                                productInfoSubset.add(temp);
                              }

                              final doc = pw.Document();

                              doc.addPage(pw.Page(
                                  pageFormat: PdfPageFormat.a4,
                                  build: (pw.Context context) {
                                    return pw.Column(
                                      children: [
                                        pw.Header(text: "Order Summary"),
                                        pw.Table.fromTextArray(headers: [
                                          "Product Name",
                                          "Price (\$)",
                                          "Quantity"
                                        ], data: productInfoSubset),
                                        pw.Divider(),
                                        pw.Footer(
                                            leading: pw.Text(
                                                "Total: \$ ${cartTotal}"),
                                            title: pw.Text(
                                                "Thank you for shopping at Shoppers!"))
                                      ],
                                    );
                                  })); //

                              await Printing.layoutPdf(
                                  onLayout: (PdfPageFormat format) async =>
                                      doc.save());
                            },
                            style:
                                ElevatedButton.styleFrom(primary: Colors.blue),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
