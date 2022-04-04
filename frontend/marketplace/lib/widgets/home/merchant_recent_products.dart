import 'package:flutter/material.dart';
import 'package:marketplace/constants/route_names.dart';
import 'package:http/http.dart' as http;
import 'package:marketplace/utils/cart_products_controller.dart';
import '../../constants/api_url.dart';
import 'dart:convert';

class mProducts extends StatefulWidget {
  @override
  _mProductsState createState() => _mProductsState();
}

class _mProductsState extends State<mProducts> {
  Future getProductList() async {
    var response = await http.get(Uri.parse(ApiUrl.get_recent_product));
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProductList(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text("Loading..."),
            ),
          );
        } else {
          CartProductsController cartController = new CartProductsController();
          return GridView.builder(
              physics: ScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 50),
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
                );
              });
        }
      },
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
  Single_prod({
    this.prod_id,
    this.prod_name,
    this.prod_picture,
    this.prod_price,
    this.cartController,
    this.prod_quantity,
    this.prod_description,
    this.prod_category,
  });

  @override
  State<Single_prod> createState() => _Single_prodState();
}

class _Single_prodState extends State<Single_prod> {
  var _categoryValues = [''];
  String new_prod_category;

  Future getCategoryList() async {
    var response = await http.get(Uri.parse(ApiUrl.edit_category));
    var jsonData = jsonDecode(response.body);
    _categoryValues = List.filled(jsonData.length, '');

    for (var i = 0; i < jsonData.length; i++) {
      _categoryValues[i] = jsonData[i]['name'];
    }

    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    //print("description: " + prod_description.toString());
    return Container(
      margin: EdgeInsets.all(15),
      child: Hero(
          tag: widget.prod_name,
          child: Material(
              child: InkWell(
            onTap: () {
              //Navigator.pushNamed(context, RouteNames.product);
              showDialog(
                context: context,
                builder: (BuildContext context) => PopupDialog(context),
              );
              //  Navigator.pushNamed(context, RouteNames.product,
              //     arguments: prod_id);
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
                                  fontWeight: FontWeight.bold, fontSize: 20.0)),
                          title: Text(
                            "\$${widget.prod_price}",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w800),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    Edit_Product_Popup(context, snapshot.data),
                              );
                              // Navigator.pushNamed(context, RouteNames.mEditProduct,
                              //     arguments: {
                              //       'paia': prod_id,
                              //       'paia2': prod_name,
                              //       'paia3': prod_picture,
                              //       'paia4': prod_description,
                              //       'paia5': new_prod_category,
                              //       'paia6': prod_price,
                              //       'paia7': prod_quantity
                              //     });
                            },
                          ),
                        );
                      })),
              child: Image.network(widget.prod_picture),
              // child: Image.asset(
              //   widget.prod_picture,
              //   fit: BoxFit.cover,
              // )
            ),
          ))),
    );
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

  Widget Edit_Product_Popup(BuildContext context, categories) {
    var new_product_name;
    var new_product_desc;
    var new_product_price;
    var new_product_image;
    // String new_product_category = categories[0]['name'];
    // var cat_list = List.filled(categories.length, '');

    // //print(categories.length);
    // for (var i = 0; i < categories.length; i++) {
    //   cat_list[i] = categories[i]['name'];
    //   //print(total_price[i - 1]);
    // }
    return new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 50,
      title: Text(
        this.widget.prod_name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          TextField(
            //controller: emailTextFieldController,
            decoration: InputDecoration(
              hintText: 'New image URL',
              labelText: 'New image URL',
              suffixIcon: Icon(
                Icons.image,
              ),
            ),
            keyboardType: TextInputType.text,
            onChanged: (newText4) {
              new_product_image = newText4;
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
      actions: <Widget>[
        new ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            onPressed: () async {
              var response = await http.delete(
                  Uri.parse(ApiUrl.delete_product + widget.prod_id.toString()));
              if (response.statusCode == 200) {
                Navigator.pushNamed(context, RouteNames.merchanthome);
              }
            },
            child: Text('Delete')),
        new ElevatedButton(
          onPressed: () async {
            //Navigator.of(context).pop();
            String uri = ApiUrl.edit_product;
            Map bodyData = {
              "id": this.widget.prod_id,
              "name": new_product_name,
              "imageUrl": new_product_image,
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
              //print('=====EDIT SUCCESS');
              //Navigator.of(context).pop();
              //AlertDialog(content: Text("Category name updated !"));
              AlertDialog editProductSuccessDialog = AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text("Failed"),
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
