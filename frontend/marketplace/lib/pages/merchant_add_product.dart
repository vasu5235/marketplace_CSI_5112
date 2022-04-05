import 'dart:convert';
import 'dart:math';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/constants/page_titles.dart';
import 'package:marketplace/constants/route_names.dart';
import 'package:marketplace/widgets/app_scaffold.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
//dabefcd17eae272941684ce4228210db616fa419
import '../constants/api_url.dart';

class MerchantAddProducts extends StatefulWidget {
  const MerchantAddProducts({Key key}) : super(key: key);

  @override
  _MerchantAddProductsState createState() => _MerchantAddProductsState();
}

class _MerchantAddProductsState extends State<MerchantAddProducts> {
  //String _categoryValue = 'test';

  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String prod_name, prod_desc, prod_price, imgURL;
  String prod_image = 'images/product_images/oatmeal.jpg';
  var _categoryValues = [''];
  String prod_category;
  //PlatformFile imgFile = null;
  String imgName;

  Future getCategoryList() async {
    var response = await http.get(Uri.parse(ApiUrl.edit_category));

    var jsonData = jsonDecode(response.body);
    _categoryValues = List.filled(jsonData.length, '');
    //_categoryValue = jsonData[0]['name'];
    //_categoryValue = prod_category;

    for (var i = 0; i < jsonData.length; i++) {
      _categoryValues[i] = jsonData[i]['name'];
    }



    print(jsonData);
    return jsonData;
  }

  String get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = nameController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Minimum 3 Characters required';
    }
    // return null if the text is valid
    return null;
  }
  String get errorDesc {
    // at any time, we can get the text from _controller.value.text
    final text = descController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Minimum 3 Characters required';
    }
    // return null if the text is valid
    return null;

  }
  String get errorImage {
    // at any time, we can get the text from _controller.value.text
    final text = imageController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Minimum 3 Characters required';
    }
    // return null if the text is valid
    return null;

  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        pageTitle: PageTitles.mAddProduct,
        body: FutureBuilder(
            future: getCategoryList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return addProductForm(snapshot.data);
              }
              else{
                return Container(child: Center(child:Text("Loading....")));
              }
            }));
  }

  Widget addProductForm(categories) {
    Size size = MediaQuery.of(context).size;

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
                        errorText: _errorText,
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
                        errorText: errorDesc,
                      ),
                      controller: descController,
                      keyboardType: TextInputType.text,
                      onChanged: (newText2) {
                        setState(() => prod_desc = newText2);
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
                        hint: Text("Select Category"),
                        isExpanded: true,
                        //value: _categoryValue,
                        value: prod_category,
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: _categoryValues.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          prod_category = value;
                          setState(() {
                            prod_category;
                          });
                        }),
                    SizedBox(
                      height: 32,
                    ),

                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Image URL',
                        labelText: 'Image URL',
                        suffixIcon: Icon(
                          Icons.image,
                        ),
                        errorText: errorImage,
                      ),
                      controller: imageController,
                      keyboardType: TextInputType.text,
                      onChanged: (newtext4) {
                        setState(() => imgURL = newtext4);
                      },
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
                            "imageUrl": imgURL,
                            //"imageUrl": image,
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
                              actions: [
                                TextButton(
                                    //add actions here if needed
                                    onPressed: () => {
                                          Navigator.pushNamed(
                                              context, RouteNames.merchanthome)
                                        },
                                    child: Text("Ok")),
                              ],
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

//
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
