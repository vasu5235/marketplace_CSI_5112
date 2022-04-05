import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:marketplace/constants/api_url.dart';
import 'package:marketplace/constants/route_names.dart';
import 'package:marketplace/widgets/home/horizontal_listview.dart';
import 'package:marketplace/widgets/home/merchant_recent_products.dart';
import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';

class MerchantHomePage extends StatefulWidget {
  const MerchantHomePage({Key key}) : super(key: key);

  @override
  State<MerchantHomePage> createState() => _MerchantHomePageState();
}

class _MerchantHomePageState extends State<MerchantHomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        pageTitle: PageTitles.merchant_home_page,
        body: new ListView(
          children: <Widget>[
            //image_carousel,
            new Padding(
                padding: const EdgeInsets.fromLTRB(22, 20, 0, 10),
                child: Row(
                  children: [
                    Text(
                      "Categories",
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () => {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    Add_Category_Popup(context),
                              )
                            },
                        child: Text("Add Category")),
                  ],
                )),
            HorizontalList(),
            new Padding(
                padding: const EdgeInsets.fromLTRB(22, 30, 0, 10),
                child: new Text(
                  "Products",
                  style: new TextStyle(fontSize: 20.0),
                )),
            Container(
              child: mProducts(),
            )
          ],
        ));
  }

  final _categoryName = TextEditingController();
  String get _errorValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _categoryName.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  Widget Add_Category_Popup(BuildContext context) {
    var new_category_name;
    var new_image_URL = null;
    return new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 50,
      title: Text(
        "Add New Category",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _categoryName,
            decoration: InputDecoration(
              hintText: 'Category Name',
              labelText: 'Category Name',
              suffixIcon: Icon(
                Icons.input,
              ),
              errorText: _errorValidation,
            ),
            keyboardType: TextInputType.text,
            onChanged: (newText) {
              new_category_name = newText;
            },
          ),
          TextField(
            //controller: _categoryName,
            decoration: InputDecoration(
              hintText: 'Image URL',
              labelText: 'Image URL',
              suffixIcon: Icon(
                Icons.image,
              ),
              //errorText: _errorValidation,
            ),
            keyboardType: TextInputType.text,
            onChanged: (newText2) {
              new_image_URL = newText2;
            },
          ),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () async {
            int randomId = Random().nextInt(99999);
            //Navigator.of(context).pop();
            String uri = ApiUrl.add_category;
            Map bodyData;
            if (new_image_URL == null) {
              bodyData = {
                "id": randomId,
                "imageURL": "images/category_images/08.png",
                "name": new_category_name,
              };
            } else {
              bodyData = {
                "id": randomId,
                "imageURL": new_image_URL,
                "name": new_category_name,
              };
            }

            var body = json.encode(bodyData);
            // print("====body===");
            // print(body);
            var response = await http.post(uri,
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
                content: Text("Category added !"),
                actions: [
                  TextButton(
                      onPressed: () => {
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
              //Navigator.pushNamed(context, RouteNames.merchanthome);
            }
          },
          // textColor: Colors.white,
          // color: Colors.red,
          child: const Text('Add'),
        ),
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          // textColor: Colors.white,
          // color: Colors.red,
          child: const Text('Close'),
        ),
        SizedBox(
          height: 64,
        ),
      ],
    );
  }
}
