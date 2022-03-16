import 'package:flutter/material.dart';
import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrdersPage extends StatefulWidget {
  OrdersPage({Key key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  //var sampleOrders;
  var count = 1;

  var total_price = List.filled(4, 0);

  Future getOrders() async {
    var response = await http.get('https://localhost:7136/api/Order');
    var jsonData = jsonDecode(response.body);

    //print(jsonData);

    for (var i = 1; i <= jsonData.length; i++) {
      for (var j = 0; j < jsonData['$i'].length; j++) {
        total_price[i - 1] += jsonData['$i'][j]['price'];
      }
      print(total_price[i - 1]);
    }

    return jsonData;
    // setState(() {
    //   sampleOrders = jsonData;
    // });
    //return jsonData;
  }

  //var sampleOrders = {};

  // _OrdersPageState() {
  //   getOrders();
  // }

  @override
  Widget build(BuildContext context) {
    // Data from Constants.SAMPLE_ORDERS
    // Layout:
    // Container with BoxDecoration
    //   Column:
    //     Row (OrderId) + Column (Total+Invoice button)
    //     Card
    //       ListView of Card(ListTile)
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
                    child: FutureBuilder(
                      future: getOrders(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: Text("Loading..."),
                            ),
                          );
                        } else
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              count = index + 1;
                              //print(snapshot.data['$count']);
                              //print(snapshot.data['$count'][0]['name']);
                              //print(snapshot.data['$count'][0]);
                              //return BuildOrdersCards(snapshot.data["1"][0]);
                              return BuildOrdersCards(snapshot.data['$count']);
                            },
                          );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// return AppScaffold(
//       pageTitle: PageTitles.orders,
//       body: Column(
//         children: <Widget>[
//           Align(
//             alignment: Alignment.center,
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(40, 20, 20, 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.8,
//                       width: MediaQuery.of(context).size.width * 0.6,
//                       child: ListView.builder(
//                         //itemCount: 10,
//                         itemCount: sampleOrders.length,
//                         itemBuilder: (context, index) {
//                           return BuildOrdersCards(sampleOrders[index]);
//                         },
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

  Widget BuildOrdersCards(order) {
    //print(order);
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
                        // "Order Id:\n ${order['id']}",
                        "Order Id:\n ${count}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Text(
                            // "Total: \$20",
                            //"Total: \$ $total",
                            "Total: \$ ${total_price[count - 1]}",

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
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ListView.builder(
                      itemCount: order.length,
                      itemBuilder: (context, index) {
                        //total = total + order[index]["price"];
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
                                      child:
                                          Image.asset(order[index]["imageUrl"]),
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
