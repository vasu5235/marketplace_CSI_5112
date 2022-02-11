import 'package:flutter/material.dart';
import 'package:marketplace/constants/page_titles.dart';
import 'package:marketplace/widgets/action_button.dart';
import 'package:marketplace/widgets/app_scaffold.dart';

class MerchantEditProducts extends StatefulWidget {
  const MerchantEditProducts({Key key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: PageTitles.mEditProduct,
      body: Center(
        child: editProductForm(),
      ),
    );
  }

  Widget editProductForm() {
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
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Product Id',
                        labelText: 'Product Id',
                        suffixIcon: Icon(
                          Icons.fingerprint,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
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
