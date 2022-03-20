import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marketplace/constants/page_titles.dart';
import 'package:marketplace/widgets/action_button.dart';
import 'package:marketplace/widgets/app_scaffold.dart';

import '../constants/api_url.dart';
import '../constants/route_names.dart';
import 'package:http/http.dart' as http;

class MerchantEditProducts extends StatefulWidget {

  final String productName;
  final int id;
  final String imageLocation;
  final String description;
  final String category;
  final int price;
  final int quantity;

  const MerchantEditProducts({Key key, this.productName, this.id, this.imageLocation, this.description, this.category, this.price, this.quantity}) : super(key: key);

  // const MerchantEditProducts(
  //     this._id, this._productName, this._imageLocation, this._description, this._category, this._price, this._quantity
  //     {Key key}) : super(key: key);

  @override
  _MerchantEditProductsState createState() => _MerchantEditProductsState();
}

class _MerchantEditProductsState extends State<MerchantEditProducts> {
  String _categoryValue = null;
  var _categoryValues = ["Clothing", "Sports", "Hiking", "Electronics"];
  void _onchanged(String value) {
    setState(() {
      _categoryValue = value;
    });
  }

  // Future getProductList() async {
  //   var response = await http.get(Uri.parse(
  //       ApiUrl.get_product_by_category + widget._productName.toLowerCase()));
  //   var jsonData = jsonDecode(response.body);
  //   return jsonData;
  // }

  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //print()
    final args = ModalRoute.of(context).settings.arguments;
    print(args);
    return AppScaffold(
      pageTitle: PageTitles.mEditProduct,
      body: Center(
        child: editProductForm(args),
      ),
    );
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

  Widget editProductForm(args) {
    Size size = MediaQuery.of(context).size;
    var new_product_name;
    var new_description;
    var new_price;
    var new_category;
    //Simple login form using TextFields and buttons from action_button.dart

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
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'args',
                        labelText: 'Product Id',
                        suffixIcon: Icon(
                          Icons.fingerprint,

//     return FutureBuilder(
//       builder: (context, snapshot) {
//         return Center(
//           child: Card(
//             elevation: 4,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(25),
//               ),
//             ),
//             child: AnimatedContainer(
//               duration: Duration(milliseconds: 200),
//               height: size.height *
//                   (size.height > 770
//                       ? 0.9
//                       : size.height > 670
//                           ? 0.8
//                           : 0.9),
//               width: 800,
//               color: Colors.white,
//               child: Center(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         TextField(
//                           controller: idController,
//                           decoration: InputDecoration(
//                             hintText: 'Product Id',
//                             labelText: 'Product Id',
//                             suffixIcon: Icon(
//                               Icons.fingerprint,
//                             ),
//                           ),

                        ),
                        SizedBox(
                          height: 32,
                        ),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Product Name',
                            labelText: 'Product Name',
                            suffixIcon: Icon(
                              Icons.shop,
                            ),
                            errorText: _errorText,
                          ),
                          onChanged: (newText){
                            new_product_name = newText;
                          },
                        ),

                        errorText: errorDesc,
                      ),
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

//                         SizedBox(
//                           height: 32,

                        ),
                        TextField(
                          controller: descController,
                          decoration: InputDecoration(
                            hintText: 'Product Description',
                            labelText: 'Description',
                            suffixIcon: Icon(
                              Icons.description,
                            ),
                            errorText: errorDesc,
                          ),
                          onChanged: (newDesc){
                            new_description = newDesc;
                          },
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          controller: priceController,
                          keyboardType:TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                          ],
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter Price',
                            suffixIcon: Icon(
                              Icons.attach_money,
                            ),
                          ),
                          onChanged: (newPrice){
                            new_price = newPrice;
                          },
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        DropdownButton(
                            isExpanded: true,
                            hint: Text("Product Category"),
                            focusColor: Colors.grey,
                            value: _categoryValue,
                            items: _categoryValues.map((String value) {
                              return DropdownMenuItem(
                                  value: value, child: Text("${value}"));
                            }).toList(),
                            onChanged: (String value) {
                              _onchanged(value);
                              new_category = value;
                            }),
                        SizedBox(
                          height: 32,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                                width: 200, height: 50),
                            child: ElevatedButton.icon(
                              label: Text('Upload Picture'),
                              icon: Icon(Icons.image),
                              onPressed: () {},
                              // style: ElevatedButton.styleFrom(primary: Colors.red),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 64,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:[
                              ElevatedButton(

                              onPressed: () async {
                                String uri = ApiUrl.edit_product;
                                Map bodyData = {
                                  "id": widget.id,
                                  "imageURL": 'images/product_images/oatmeal.jpg',
                                  "name": new_product_name,
                                  "description": new_description,
                                  "category": new_category,
                                  "price":new_price,
                                  "quantity": '1',
                                };
                                var body = json.encode(bodyData);
                                // print("====body===");
                                print(body);
                                var response = await http.put(uri,
                                    headers: {
                                      'Content-Type': 'application/json',
                                      'accept': 'text/plain'
                                    },
                                    body: body);
                                //print("Response\n" + response.body);

                                if (response.body == "true") {
                                  //print('=====EDIT SUCCESS');
                                  //Navigator.of(context).pop();
                                  //AlertDialog(content: Text("Category name updated !"));
                                  AlertDialog editProductSuccessDialog = AlertDialog(
                                    // Retrieve the text the that user has entered by using the
                                    // TextEditingController.
                                    content: Text("Product updated Successfully!"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                          {
                                            Navigator.pushNamed(
                                                context, RouteNames.merchanthome)
                                          },
                                          child: Text("Ok"))
                                    ],
                                  );

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return editProductSuccessDialog;
                                    },
                                  );
                                };
                              },
                              child:
                              const Text('Edit Product'),
                            ),
                            TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        Delete_Product_Popup(context),
                                  );
                                },
                                child: const Text(
                                  'Delete Product', style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                )
                            )
                              ]
                        ),

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
    );
  }
  Widget Delete_Product_Popup(BuildContext context) {
    var response;
    var jsonData;
    return new AlertDialog(
      // Retrieve the text the that user has entered by using the
      // TextEditingController.
      content: Text("Are you sure you want to delete ?"),
      actions: [
        TextButton(
          //add actions here if needed
            onPressed: () async => {
              //deletehere
              response = await http.delete(Uri.parse(
                  ApiUrl.delete_product + widget.id.toString())),
              jsonData = jsonDecode(response.body),
              //print(jsonData),
              if (jsonData == true)
                {
                  Navigator.pushNamed(context, RouteNames.merchanthome)
                  // AlertDialog(
                  //   // Retrieve the text the that user has entered by using the
                  //   // TextEditingController.
                  //   content: Text("Category deleted!"),
                  //   actions: [
                  //     TextButton(
                  //         onPressed: () => {
                  //               Navigator.pushNamed(
                  //                   context, RouteNames.merchanthome)
                  //             },
                  //         child: Text("Ok"))
                  //   ],
                  // ),
                },

              //Navigator.pushNamed(context, RouteNames.merchanthome)
            },
            child: Text("Yes")),
        ElevatedButton(
            onPressed: () => {Navigator.of(context).pop()}, child: Text("No"))
      ],
    );

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return deleteProductSuccessDialog;
    //   },
    // );
  }
}
