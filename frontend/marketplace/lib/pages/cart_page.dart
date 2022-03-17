import 'package:flutter/material.dart';
import 'package:marketplace/utils/cart_products_controller.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';
import 'cart_products.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
                        onPressed: () {},
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
