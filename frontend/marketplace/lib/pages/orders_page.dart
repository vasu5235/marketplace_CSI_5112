import 'package:flutter/material.dart';
import '../constants/constants.dart' as Constants;
import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';

class OrdersPage extends StatefulWidget {
  OrdersPage({Key key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  var sampleOrders = Constants.SAMPLE_ORDERS;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: PageTitles.orders,
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 20, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ListView.builder(
                        itemCount: sampleOrders.length,
                        itemBuilder: (context, index) {
                          return BuildOrdersCards(sampleOrders[index]);
                        },
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildOrdersCards(order) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Id:\n 123-456",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Text(
                            "Total: \$20",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.download),
                            label: Text('Invoice'),
                            onPressed: () {},
                          )
                        ],
                      )
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ListView.builder(
                      itemCount: order.length,
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              side: new BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    order[index]['name'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text('\$${order[index]["price"]}'),
                                  leading: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 20.0),
                                    child: Expanded(
                                      child: Image.asset(order[index]["image"]),
                                      // flex: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      })),
            ),
          ],
        ),
      ),
    );
  }
}


/*
Card(
        elevation: 20,
        child: Column(
          children: [
            ListTile(
              title: const Text(
                '1625 Main Street',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: const Text('My City, CA 99984'),
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Expanded(
                  child: Image.asset("images/product_images/iphone.jpg"),
                  // flex: 8,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text(
                '(408) 555-1212',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
            ),
          ],
        ));
*/