import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: PageTitles.mEditProduct,
      body: Center(
        child: editProductForm(),
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


  Widget editProductForm() {
    Size size = MediaQuery.of(context).size;

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
                      controller: idController,
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
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Product Name',
                        labelText: 'Product Name',
                        suffixIcon: Icon(
                          Icons.shop,
                        ),
                        errorText: _errorText,
                      ),
                    ),
                    SizedBox(
                      height: 32,
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
