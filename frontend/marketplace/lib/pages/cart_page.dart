import 'package:flutter/material.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';
import 'cart_products.dart';

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
                            onPressed: () {},
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
