import 'package:flutter/material.dart';
import 'package:marketplace/constants/page_titles.dart';
import 'package:marketplace/widgets/action_button.dart';
import 'package:marketplace/widgets/app_scaffold.dart';

class MerchantAddProducts extends StatefulWidget {
  const MerchantAddProducts({Key key}) : super(key: key);

  @override
  _MerchantAddProductsState createState() => _MerchantAddProductsState();
}

class _MerchantAddProductsState extends State<MerchantAddProducts> {
  String _categoryValue = null;
  var _categoryValues = ["Clothing", "Sports", "Hiking", "Electronics"];

  void _onchanged(String value) {
    setState(() {
      _categoryValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        pageTitle: PageTitles.mAddProduct, body: addProductForm());
  }

  Widget addProductForm() {
    Size size = MediaQuery.of(context).size;
    //Simple form using TextFields and buttons from action_button.dart
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
                    // Text(
                    //   "SIGN UP",
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     color: Colors.grey[700],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // Container(
                    //   width: 30,
                    //   child: Divider(
                    //     color: Color(0xFFFE4350),
                    //     thickness: 2,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 32,
                    // ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Product Name',
                        labelText: 'Product Name',
                        suffixIcon: Icon(
                          Icons.shop,
                        ),
                      ),
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
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Price',
                        labelText: 'Price',
                        suffixIcon: Icon(Icons.attach_money),
                      ),
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
                    actionButton(context, "Submit"),
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
