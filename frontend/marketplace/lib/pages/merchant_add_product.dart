import 'dart:convert';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marketplace/constants/page_titles.dart';

import 'package:marketplace/widgets/app_scaffold.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import '../constants/api_url.dart';

class MerchantAddProducts extends StatefulWidget {
  const MerchantAddProducts({Key key}) : super(key: key);

  @override
  _MerchantAddProductsState createState() => _MerchantAddProductsState();
}

class _MerchantAddProductsState extends State<MerchantAddProducts> {

  String _categoryValue = null;
  var _categoryValues = [''];
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String prod_name, prod_desc,prod_price;
  String prod_image = 'images/product_images/oatmeal.jpg';
  String prod_category ;

  Future getCategoryList() async {
    var response = await http.get(Uri.parse(ApiUrl.edit_category));

    var jsonData = jsonDecode(response.body);

    print(jsonData);
    return jsonData;
  }

//   var _categoryValues;
//   var category_keys;
//   var total_price;
//   Future getAllCategories() async {
//     // _loadSession();
//     var response = await http.get(Uri.parse(ApiUrl.get_category));
//     var jsonData = jsonDecode(response.body);
//     print(jsonData);
//     var data1;
//     for (data1 in jsonData) {
//       print(data1.name);
//       _categoryValues = data1['name'] as List;
//     }

//     // category_keys = jsonData.keys.toList();
//     // _categoryValues = List.filled(jsonData.keys.length, '');
//     // for (var i = 1; i <= jsonData.length; i++) {
//     //   for (var j = 0; j < jsonData['${category_keys[i - 1]}'].length; j++) {
//     //     _categoryValues[i - 1].add(jsonData['${category_keys[i - 1]}'][j]['name']);
//     //   }
//     //   print(_categoryValues[i - 1]);
//     // }
//     return jsonData;
//   }

//   String _categoryValue = null;
//   // var _categoryValues;


  void _onchanged(String value) {
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


//   Future _pickFile() async {
//     final result = await FilePicker.platform.pickFiles(type: FileType.image);

//     // if(result == null) return;
//     //
//     //
//     // PlatformFile image = result.files.single;
//     //
//     //print(image.path );
//     if(result != null) {
//       final file = result.files.first;

//       print(file.name);
//       // print(file.bytes);
//       print(file.size);
//       print(file.extension);
//       print(file.path);

//     }
//     else {}
//   }

  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController priceController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getAllCategories(),
//         builder: (context, snapshot) {
//           if (snapshot.data == null) {
//             return Transform.scale(
//               scale: 0.2,
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return AppScaffold(
//                 pageTitle: PageTitles.mAddProduct, body: addProductForm());
//           }
//         }
//     );

//   }

//   String get _errorText {
//     // at any time, we can get the text from _controller.value.text
//     final text = nameController.value.text;
//     // Note: you can do your own custom validation here
//     // Move this logic this outside the widget for more testable code
//     if (text.isEmpty) {
//       return 'Can\'t be empty';
//     }
//     if (text.length < 4) {
//       return 'Minimum 3 Characters required';
//     }
//     // return null if the text is valid
//     return null;
//   }
//   String get errorDesc {
//     // at any time, we can get the text from _controller.value.text
//     final text = descController.value.text;
//     // Note: you can do your own custom validation here
//     // Move this logic this outside the widget for more testable code
//     if (text.isEmpty) {
//       return 'Can\'t be empty';
//     }
//     if (text.length < 4) {
//       return 'Minimum 3 Characters required';
//     }
//     // return null if the text is valid
//     return null;

  }

  Widget addProductForm(categories) {
    Size size = MediaQuery.of(context).size;
    // var prod_name;
    // var prod_desc;
    // var prod_price = 0;
    // var prod_category;
    //var prod_image = 'images/product_images/oatmeal.jpg';
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
                      controller: nameController,
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
                      controller: descController,
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

                       controller: priceController,
//                       keyboardType:TextInputType.numberWithOptions(decimal: true),

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
                        prod_price = newText3.toString();
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
                          prod_category = value;
                        }

                        //value: new_product_category,
                        // change button value to selected value


                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(
                            width: 200, height: 50),
                        child: ElevatedButton(
                           child: Text('Upload Picture'),
                          onPressed: () {
                             // _pickFile();
                          },
                          // style: ElevatedButton.styleFrom(primary: Colors.red),

                        ),
                      )
                    ),
                    SizedBox(
                      height: 64,
                    ),

                    ElevatedButton(
                        onPressed: () async {
                          var qty = 1;
                          var image = 'images/product_images/oatmeal.jpg';
                          int randomId = Random().nextInt(99999);

                          Map bodyData = {
                            "id": randomId,
                            "name": prod_name,
                            "description": prod_desc,
                            "category": prod_category,
                            "price": prod_price,
                            "imageUrl": image,
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


//                     ElevatedButton(onPressed: () async {
//                       var name = nameController.text;
//                       var desc = descController.text;
//                       var category = categoryController.text;
//                       var price = priceController.text;
//                       var qty = 1;
//                       var imageUrl = 'images/product_images/oatmeal.jpg';
//                       int randomId = Random().nextInt(99999);

//                       Map bodyData = {
//                         "id": randomId,
//                         "name": name,
//                         "imageUrl":imageUrl,
//                         "description": desc,
//                         "category": category,
//                         "price": price,
//                         "quantity":qty,
//                       };

//                       var body = json.encode(bodyData);

//                       // print("email: " + emailTextFieldController.text);
//                       // print("password: " + passwordFieldController.text);
//                       String uri = ApiUrl.envUrl;
//                       final url = Uri.encodeFull("${uri}/Product");

//                       // print("===URL===" + url);

//                       var response = await http.post(url,
//                           headers: {'Content-Type': 'application/json'},
//                           body: body);
//                       print("Response\n" + response.body);

//                       if (response.body == "true") {
//                         AlertDialog addProductDialog = AlertDialog(
//                           // Retrieve the text the that user has entered by using the
//                           // TextEditingController.
//                           content: Text(
//                               "Success!, Product added successfully!"),
//                         );

//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return addProductDialog;
//                           },
//                         );
//                       } else {
//                         AlertDialog addProductFailure = AlertDialog(
//                           // Retrieve the text the that user has entered by using the
//                           // TextEditingController.
//                           content: Text(
//                               "Oops! Failed to add product, please try again"),
//                         );

//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return addProductFailure;
//                           },
//                         );
//                       }
//                     },

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
