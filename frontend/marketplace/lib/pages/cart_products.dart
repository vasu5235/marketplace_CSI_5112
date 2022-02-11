import 'package:flutter/material.dart';
import '../constants/constants.dart' as Constants;

class CartProducts extends StatefulWidget {
  const CartProducts({Key key}) : super(key: key);

  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var _productList = Constants.SAMPLE_CART_PRODUCTS;

  @override
  Widget build(BuildContext context) {
    // Return all products displayed using Card in a SizedBox. Iterate using ListView
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.6,
      child: ListView.builder(
        itemCount: _productList.length,
        itemBuilder: (context, index) {
          return SingleCartProduct(
            productName: _productList[index]['name'],
            productImageURL: _productList[index]['image'],
            productPrice: _productList[index]['price'],
          );
        },
      ),
    );
  }
}

class SingleCartProduct extends StatefulWidget {
  final productName;
  final productImageURL;
  final productPrice;

  SingleCartProduct(
      {this.productName, this.productImageURL, this.productPrice});

  @override
  State<SingleCartProduct> createState() => _SingleCartProductState();
}

class _SingleCartProductState extends State<SingleCartProduct> {
  var productQuantity = 1;

  @override
  Widget build(BuildContext context) {
    // Return new card containing all product details
    return Container(
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 10,
          child: Container(
            height: 100,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 18.0, 10.0, 10.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.08,
                      maxHeight: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Image.asset('images/product_images/iphone.jpg',
                        fit: BoxFit.fill),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: ListTile(
                            title: Text(widget.productName),
                            subtitle: Text("Sold by: Apple Inc."),
                            trailing: Text(
                              "\$${widget.productPrice}",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Quantity: ${productQuantity}",
                                  style: TextStyle(height: 2.0),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                _decrementButton(),
                                SizedBox(width: 6),
                                _incrementButton(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  flex: 8,
                ),
              ],
            ),
          )),
    );
  }

  // Increment button (todo: can be shifted to widgets folder)
  Widget _incrementButton() {
    return SizedBox(
      width: 30,
      height: 30,
      child: FittedBox(
        child: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.black87),
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              productQuantity++;
            });
          },
        ),
      ),
    );
  }

  // Decrement button (todo: can be shifted to widgets folder)
  Widget _decrementButton() {
    return SizedBox(
      width: 30,
      height: 30,
      child: FittedBox(
        child: FloatingActionButton(
            onPressed: () {
              setState(() {
                productQuantity--;
              });
            },
            child: new Icon(Icons.remove, color: Colors.black87),
            backgroundColor: Colors.white),
      ),
    );
  }
}
