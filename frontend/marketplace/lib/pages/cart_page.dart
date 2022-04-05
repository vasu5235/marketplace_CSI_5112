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
                  "Order Total: " +
                      CartProductsController().getTotal().toString(),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.023,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                          children: <Widget>[
                            new ElevatedButton.icon(
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
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue),
                            ),
                            SizedBox(width: 20),
                            new ElevatedButton.icon(
                              label: Text('Checkout'),
                              icon: Icon(Icons.shopping_bag_rounded),
                              onPressed: () async {
                                var _productList =
                                    await CartProductsController()
                                        .getProducts();

                                if (_productList.length == 0) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text('Your cart is empty'),
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
                                  return;
                                }

                                var body = json.encode(_productList);

                                var session = FlutterSession();
                                var randomId =
                                    await Random().nextInt(99999999).toString();
                                var _userId = 0;
                                _userId = await session.get("user_id");
                                var orderid =
                                    _userId.toString() + '-' + randomId;
                                String uri =
                                    ApiUrl.checkout + orderid.toString();

                                var response = await http.post(uri,
                                    headers: {
                                      'Content-Type': 'application/json',
                                      'accept': 'text/plain'
                                    },
                                    body: body);

                                if (response.body == "true") {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title:
                                                Text('Success- Order Placed'),
                                            content: Text(
                                                'Thank you for shopping at Shoppers !'),
                                            actions: [
                                              TextButton(
                                                  child: Text('Ok'),
                                                  onPressed: () => {
                                                        CartProductsController()
                                                            .clearCart(),
                                                        Navigator.pushNamed(
                                                            context,
                                                            RouteNames.home)
                                                        //Navigator.pop(context)
                                                        //setState(() {})
                                                      })
                                            ],
                                          ));

                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text('Failed'),
                                            content: Text(
                                                'Sorry, something went wrong :('),
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
                                }
                              },
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                            ),
                          ]))
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: CartProducts(),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
