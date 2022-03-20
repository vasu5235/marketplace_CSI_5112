import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marketplace/constants/page_titles.dart';
import 'package:marketplace/widgets/app_scaffold.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import '../constants/api_url.dart';

class MerchantAddProducts extends StatefulWidget {
  const MerchantAddProducts({Key key}) : super(key: key);

  @override
  _MerchantAddProductsState createState() => _MerchantAddProductsState();
}

class _MerchantAddProductsState extends State<MerchantAddProducts> {
  String _categoryValue = null;
  var _categoryValues = [''];
  Future getCategoryList() async {
    var response = await http.get(Uri.parse(ApiUrl.edit_category));

    var jsonData = jsonDecode(response.body);

    print(jsonData);
    return jsonData;
  }

  void _onchanged1(String value) {
    setState(() {
      _categoryValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        pageTitle: PageTitles.mAddProduct,
        body: FutureBuilder(
            future: getCategoryList(),
            builder: (context, snapshot) {
              return addProductForm(snapshot.data);
            }));
  }

  Widget addProductForm(categories) {
    Size size = MediaQuery.of(context).size;
    var prod_name;
    var prod_desc;
    var prod_price = 0;
    var prod_category;
    var prod_image = 'images/product_images/oatmeal.jpg';
    _categoryValues = List.filled(categories.length, '');
    _categoryValue = categories[0]['name'];
    for (var i = 0; i < categories.length; i++) {
      _categoryValues[i] = categories[i]['name'];
      //print(total_price[i - 1]);
    }
    return Center(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: size.height *
              (size.height > 770
                  ? 0.9
                  : size.height > 670
                      ? 0.8
                      : 0.9),
          width: 800,
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Product Name',
                        labelText: 'Product Name',
                        suffixIcon: Icon(
                          Icons.shop,
                        ),
                        //errorText: _errorText,
                      ),
                      //controller: nameController,
                      keyboardType: TextInputType.text,
                      onChanged: (newText1) {
                        setState(() => prod_name = newText1);
                        //prod_name = newText1;
                      },
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Product Description',
                        labelText: 'Description',
                        suffixIcon: Icon(
                          Icons.description,
                        ),
                        //errorText: errorDesc,
                      ),
                      //controller: descController,
                      keyboardType: TextInputType.text,
                      onChanged: (newText2) {
                        prod_desc = newText2;
                      },
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}'))
                      ],
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter Price',
                        suffixIcon: Icon(
                          Icons.attach_money,
                        ),
                      ),
                      onChanged: (newText3) {
                        prod_price = int.parse(newText3);
                      },
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    DropdownButton(
                        // Initial Value
                        isExpanded: true,
                        value: _categoryValue,
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: _categoryValues.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          _onchanged1(value);
                        }
                        //value: new_product_category,
                        // change button value to selected value
                        ),
                    SizedBox(
                      height: 64,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          var qty = 1;
                          int randomId = Random().nextInt(99999);

                          Map bodyData = {
                            "id": randomId,
                            "name": prod_name,
                            "description": prod_desc,
                            "category": prod_category,
                            "price": prod_price,
                            "image": prod_image,
                            "quantity": qty,
                          };

                          var body = json.encode(bodyData);
                          print(body);
                          // print("email: " + emailTextFieldController.text);
                          // print("password: " + passwordFieldController.text);
                          String uri = ApiUrl.add_product;
                          //final url = Uri.encodeFull("${uri}/Product");

                          // print("===URL===" + url);

                          var response = await http.post(uri,
                              headers: {'Content-Type': 'application/json'},
                              body: body);
                          print("Response\n" + response.body);

                          if (response.body == "true") {
                            AlertDialog signUpResultDialog = AlertDialog(
                              // Retrieve the text the that user has entered by using the
                              // TextEditingController.
                              content:
                                  Text("Success!, Product added successfully!"),
                            );

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return signUpResultDialog;
                              },
                            );
                          } else {
                            AlertDialog signUpFailure = AlertDialog(
                              // Retrieve the text the that user has entered by using the
                              // TextEditingController.
                              content: Text(
                                  "Oops! Failed to add product, please try again"),
                            );

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return signUpFailure;
                              },
                            );
                          }
                        },
                        child: Text("Submit")),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
