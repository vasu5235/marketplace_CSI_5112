import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import '../constants/route_names.dart';
import '../widgets/app_scaffold.dart';
import '../../constants/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:marketplace/utils/cart_products_controller.dart';


class CategoryFilteredProductsPage extends StatefulWidget {
  final String _categoryName;
  final int _id;
  final String _imageLocation;

  const CategoryFilteredProductsPage(
      this._id, this._categoryName, this._imageLocation,
      {Key key})
      : super(key: key);

  @override
  State<CategoryFilteredProductsPage> createState() =>
      _CategoryFilteredProductsPageState();
}

class _CategoryFilteredProductsPageState
    extends State<CategoryFilteredProductsPage> {
  var session = FlutterSession();
  var _userIsMerchant = false;

  Future<dynamic> _loadSession() async {
    _userIsMerchant = await session.get("user_is_merchant");
  }

  Future getProductList() async {
    var response = await http.get(Uri.parse(
        ApiUrl.get_product_by_category + widget._categoryName.toLowerCase()));
    var jsonData = jsonDecode(response.body);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: "${widget._categoryName}",

      body: Column(children: <Widget>[
        FutureBuilder(
            future: _loadSession(),
            builder: (context, snapshot) {
              if (_userIsMerchant) {
                return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      Edit_Category_Popup(context),
                                );
                              },
                              child: const Text(
                                'Edit Category',
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        Delete_Category_Popup(context),
                                  );
                                },
                                child: const Text(
                                  'Delete Category',
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ))
                          ],
                        )));
              } else {
                return SizedBox();
              }
            }),
        Expanded(
            child: FutureBuilder(
          future: getProductList(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text("No products to display in this category"),
                ),
              );
            } else {
              CartProductsController cartController =
                  new CartProductsController();
              return GridView.builder(
                  physics: ScrollPhysics(), // to disable GridView's scrolling
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return Single_prod(
                        prod_id: snapshot.data[index]['id'],
                        prod_name: snapshot.data[index]['name'],
                        prod_picture: snapshot.data[index]['imageUrl'],
                        prod_price: snapshot.data[index]['price'],
                        prod_quantity: snapshot.data[index]['quantity'],
                        prod_description: snapshot.data[index]['description'],
                        prod_category: snapshot.data[index]['category'],
                        cartController: cartController,
                        userIsMerchant: _userIsMerchant);
                  });
            }
          },
        ))
      ]),

      //),
    );
  }

  Widget Delete_Category_Popup(BuildContext context) {
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
                      ApiUrl.delete_category + widget._id.toString())),
                  jsonData = jsonDecode(response.body),
                  //print(jsonData),
                  if (jsonData == true)
                    {
                      Navigator.pushNamed(context, RouteNames.merchanthome)

                    },
                },
            child: Text("Yes")),
        ElevatedButton(
            onPressed: () => {Navigator.of(context).pop()}, child: Text("No"))
      ],
    );
  }

  final _categoryName = TextEditingController();
  String get _errorValidation {
    final text = _categoryName.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    return null;
  }
  final _categoryImage = TextEditingController();
  Widget Edit_Category_Popup(BuildContext context) {
    var new_category_name;
    var new_image_url = null;
    return new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 50,
      title: Text(
        widget._categoryName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _categoryName..text = widget._categoryName,
            decoration: InputDecoration(
              hintText: 'New Category Name',
              labelText: 'New Category Name',
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
            controller: _categoryImage..text = widget._imageLocation,
            decoration: InputDecoration(
              hintText: 'New Image URL',
              labelText: 'New Image URL',
              suffixIcon: Icon(
                Icons.image,
              ),
            ),
            keyboardType: TextInputType.text,
            onChanged: (newText2) {
              new_image_url = newText2;
            },
          ),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () async {
            String uri = ApiUrl.edit_category;
            Map bodyData;
            if (new_image_url == null) {
              bodyData = {
                "id": widget._id,
                "imageURL": widget._imageLocation,
                "name": new_category_name,
              };
            } else {
              bodyData = {
                "id": widget._id,
                "imageURL": new_image_url,
                "name": new_category_name,
              };
            }

            var body = json.encode(bodyData);
            var response = await http.put(uri,
                headers: {
                  'Content-Type': 'application/json',
                  'accept': 'text/plain'
                },
                body: body);

            if (response.body == "true") {

              AlertDialog editProductSuccessDialog = AlertDialog(
                content: Text("Category name updated !"),
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
            }
          },

          child: const Text('Save'),
        ),
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },

          child: const Text('Close'),
        ),
        SizedBox(
          height: 64,
        ),
      ],
    );
  }
}

class Single_prod extends StatefulWidget {
  final prod_id;
  final prod_name;
  final prod_picture;
  final prod_price;
  final prod_quantity;
  final prod_description;
  final prod_category;
  final CartProductsController cartController;
  final userIsMerchant;
  Single_prod(
      {this.prod_id,
      this.prod_name,
      this.prod_picture,
      this.prod_price,
      this.cartController,
      this.prod_quantity,
      this.prod_description,
      this.prod_category,
      this.userIsMerchant});

  @override
  State<Single_prod> createState() => _Single_prodState();
}

class _Single_prodState extends State<Single_prod> {
  var _categoryValues = [''];
  String new_prod_category;

  Future getCategoryList() async {
    var response = await http.get(Uri.parse(ApiUrl.edit_category));

    var jsonData = jsonDecode(response.body);

    print(jsonData);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userIsMerchant) {
      return Container(
        margin: EdgeInsets.all(15),
        child: Hero(
            tag: widget.prod_name,
            child: Material(
                child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => PopupDialog(context),
                );
              },
              child: GridTile(
                  footer: Container(
                      color: Colors.white70,
                      child: FutureBuilder(
                          future: getCategoryList(),
                          builder: (context, snapshot) {
                            return ListTile(
                              leading: Text(widget.prod_name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                              title: Text(
                                "\$${widget.prod_price}",
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w800),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        Edit_Product_Popup(
                                            context, snapshot.data),
                                  );
                                },
                              ),
                            );
                          })),
                  child: Image.network(widget.prod_picture, fit: BoxFit.cover)
                  ),
            ))),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(15),
        child: Hero(
            tag: widget.prod_name,
            child: Material(
                child: InkWell(
              onTap: () {
                  showDialog(
                  context: context,
                  builder: (BuildContext context) => PopupDialog(context),
                );
              },
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(widget.prod_name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      title: Text(
                        "\$${widget.prod_price}",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.add_box_rounded),
                        onPressed: () {
                          widget.cartController.addProductToCart(
                              widget.prod_id,
                              widget.prod_name,
                              widget.prod_picture,
                              widget.prod_price,
                              widget.prod_quantity,
                              widget.prod_description,
                              widget.prod_category);
                          AlertDialog addToCartSuccess = AlertDialog(
                            // Retrieve the text the that user has entered by using the
                            // TextEditingController.
                            content: Text("Product added to cart!"),
                          );

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return addToCartSuccess;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  child: Image.network(widget.prod_picture, fit: BoxFit.cover)
                ),
            ))),
      );
    }
  }

  Widget PopupDialog(BuildContext context) {
    return new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 50,
      title: Text(
        widget.prod_name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 32,
          ),
          Text("Price: \$ ${widget.prod_price.toString()}",
              style: TextStyle(fontSize: 20)),
          //Text(prod_price.toString()),
          SizedBox(
            height: 16,
          ),
          Flexible(
            child:
                Text(widget.prod_description, style: TextStyle(fontSize: 20)),
          )
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        SizedBox(
          height: 64,
        ),
      ],
    );
  }

  Widget Edit_Product_Popup(BuildContext context, categories) {
    var new_product_name;
    var new_product_desc;
    var new_product_price;
    _categoryValues = List.filled(categories.length, '');
    new_prod_category = categories[0]['name'];

    for (var i = 0; i < categories.length; i++) {
      _categoryValues[i] = categories[i]['name'];
    }
    for (var i = 0; i < categories.length; i++) {}
    return new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 50,
      title: Text(
        this.widget.prod_name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ),
      content: SizedBox(
        width: 20,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () async {
                  var response = await http.delete(Uri.parse(
                      ApiUrl.delete_product + widget.prod_id.toString()));
                  if (response.statusCode == 200) {
                    Navigator.pushNamed(context, RouteNames.merchanthome);
                  }
                },
                child: Text('Delete')),
            TextField(
              //controller: emailTextFieldController,
              decoration: InputDecoration(
                hintText: 'New Product Name',
                labelText: 'New Product Name',
                suffixIcon: Icon(
                  Icons.input,
                ),
              ),
              keyboardType: TextInputType.text,
              onChanged: (newText1) {
                new_product_name = newText1;
              },
            ),
            TextField(
              //controller: emailTextFieldController,
              decoration: InputDecoration(
                hintText: 'New Price',
                labelText: 'New Price',
                suffixIcon: Icon(
                  Icons.input,
                ),
              ),
              keyboardType: TextInputType.text,
              onChanged: (newText2) {
                new_product_price = newText2;
              },
            ),
            TextField(
              //controller: emailTextFieldController,
              keyboardType: TextInputType.multiline,
              minLines: 2, //Normal textInputField will be displayed
              maxLines: 5,

              decoration: InputDecoration(
                hintText: 'New Description',
                labelText: 'New Description',
                suffixIcon: Icon(
                  Icons.input,
                ),
              ),
              onChanged: (newText3) {
                new_product_desc = newText3;
              },
            ),
            StatefulBuilder(
                builder: (BuildContext context, StateSetter dropDownState) {
              return DropdownButton<String>(
                hint: Text("Select Category"),
                value: new_prod_category,
                underline: Container(),
                items: _categoryValues.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String value) {
                  dropDownState(() {
                    new_prod_category = value;
                  });
                },
              );
            }),
          ],
        ),
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () async {
            //Navigator.of(context).pop();
            String uri = ApiUrl.edit_product;
            Map bodyData = {
              "id": this.widget.prod_id,
              "name": new_product_name,
              "imageUrl": this.widget.prod_picture,
              "description": new_product_desc,
              "category": new_prod_category,
              "price": new_product_price,
              "quantity": this.widget.prod_quantity
            };
            var body = json.encode(bodyData);
            // print("====body===");
            // print(body);
            var response = await http.put(uri,
                headers: {
                  'Content-Type': 'application/json',
                  'accept': 'text/plain'
                },
                body: body);
            //print("Response\n" + response.body);

            if (response.body == "false") {

              AlertDialog editProductSuccessDialog = AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text("Failed"),
                actions: [
                  TextButton(
                      onPressed: () => {Navigator.of(context).pop()},
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
            } else {

              Navigator.pushNamed(context, RouteNames.merchanthome);
            }
          },
          // textColor: Colors.white,
          // color: Colors.red,
          child: const Text('Save'),
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
