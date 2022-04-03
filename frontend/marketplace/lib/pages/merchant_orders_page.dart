import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/api_url.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class mOrdersPage extends StatefulWidget {
  mOrdersPage({Key key}) : super(key: key);

  @override
  State<mOrdersPage> createState() => _mOrdersPageState();
}

class User {
  const User(this.id, this.name);

  final String name;
  final int id;
}

class _mOrdersPageState extends State<mOrdersPage> {
  var order_keys;
  var total_price;
  var user_keys;
  static var cartProducts = [
    {
      'id': 9999999,
      'name': 'sample Product',
      'imageUrl': 'images/product_images/iphone.jpg',
      'price': 400,
      'quantity': 1,
      'description': 'sample desc',
      //add
      'category': 'Food'
    },
  ];
  //var _UserValues = [''];
  List<User> users = [];
  var _selectedValue = 0;
  //var _selectedname = "user";

  Future getOrders() async {
    var response_users = await http.get(ApiUrl.get_all_users);
    var jsonData_users = jsonDecode(response_users.body);
    users = [];
    for (var i = 0; i < jsonData_users.length; i++) {
      if (jsonData_users[i]['name'] != "Merchant") {
        users.add(User(jsonData_users[i]['id'], jsonData_users[i]['name']));
      }
    }
    //_selectedname = users[_selectedValue].name;

    print("====Furute===");
    print(users[0].name);
    print("====Furute===");
    var response =
        await http.get(ApiUrl.get_orders_by_userid + _selectedValue.toString());
    var jsonData = jsonDecode(response.body);
    order_keys = jsonData.keys.toList();
    total_price = List.filled(jsonData.keys.length, 0);
    for (var i = 1; i <= jsonData.length; i++) {
      for (var j = 0; j < jsonData['${order_keys[i - 1]}'].length; j++) {
        total_price[i - 1] += jsonData['${order_keys[i - 1]}'][j]['price'];
      }
      //print(total_price[i - 1]);
    }
    return jsonData;
  }

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
      pageTitle: PageTitles.mOrders,
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
                        //hereeee

                        if (snapshot.data == null) {
                          return Column(
                            children: [
                              DropdownButton(
                                // Initial Value
                                hint: Text("Select User"),
                                isExpanded: true,
                                //value: _categoryValue,
                                //value: _selectedValue,
                                //value: users[_selectedValue].name,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                // Array list of items
                                items: users
                                    .map((data) => DropdownMenuItem(
                                          child: Text(data.name),
                                          value: data.id,
                                        ))
                                    .toList(),

                                onChanged: (var value) {
                                  _selectedValue = value;
                                  //_selectedname = users[_selectedValue].name;
                                  setState(() {
                                    _selectedValue;
                                    //_selectedname;
                                    // print("==user name==");
                                    // print(users[_selectedValue].name);
                                    // print("==user name==");
                                    print("==user id==");
                                    print(_selectedValue);
                                    print("==user id==");
                                  });
                                },
                              ),
                              Text("No Orders for this user"),
                            ],
                          );
                        } else
                          return Column(
                            children: [
                              DropdownButton(
                                // Initial Value
                                hint: Text("Select User"),
                                isExpanded: true,
                                //value: _selectedname,
                                //value: users[_selectedValue].name,
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: users
                                    .map((data) => DropdownMenuItem(
                                          child: Text(data.name),
                                          value: data.id,
                                        ))
                                    .toList(),

                                onChanged: (var value) {
                                  //_selectedname = users[_selectedValue].name;
                                  _selectedValue = value;
                                  setState(() {
                                    //_selectedname;
                                    _selectedValue;
                                    // _selectedname =
                                    //     users[_selectedValue - 1].name;
                                    // print(_selectedValue);
                                    // print("==user name==");
                                    // print(_selectedname);
                                    // print("==user name==");
                                    print("==user id==");
                                    print(_selectedValue);
                                    print("==user id==");
                                  });
                                },
                                // onChanged: (String value) {
                                //   prod_category = value;
                                //   setState(() {
                                //     prod_category;
                                //   });
                                // }
                              ),
                              Expanded(
                                child: ListView.builder(
                                  //physics: ScrollPhysics(),
                                  //shrinkWrap: true,

                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return BuildOrdersCards(index,
                                        snapshot.data[order_keys[index]]);
                                  },
                                ),
                              ),
                            ],
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

  Widget BuildOrdersCards(index, order) {
    print(order[index]);
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
                        "Order Id:\n ${order_keys[index]}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Text(
                            // "Total: \$20",
                            //"Total: \$ $total",
                            "Total: \$ ${total_price[index]}",
                            //"Total: \$ 0",

                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.download),
                            label: Text('Invoice'),
                            onPressed: () async {
                              for (var i = 0; i < order.length; i++) {
                                cartProducts.add({
                                  'id': order[i]['id'],
                                  'name': order[i]['name'],
                                  'imageUrl': order[i]['imageUrl'],
                                  'price': order[i]['price'],
                                  'quantity': order[i]['quantity'],
                                  'description': order[i]['description'],
                                  'category': order[i]['category']
                                });
                              }

                              List<Map<String, Object>> currentCartProducts =
                                  cartProducts.sublist(1);

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
                                    child:
                                        Image.asset(order[index]["imageUrl"]),
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
