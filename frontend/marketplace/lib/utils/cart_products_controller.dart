class CartProductsController {
  static var cartProducts = [
    // {
    //   //"id": 10,
    //   'name': 'iPhone 123',
    //   'imageUrl': 'images/product_images/iphone.jpg',
    //   //"description": "asdasd",
    //   //"category": "cloth",
    //   'price': 100,
    //   //"quantity": 1
    // },

    {
      'id': 9999999,
      'name': 'sample Product',
      'imageUrl': 'images/product_images/iphone.jpg',
      'price': 400,
      'quantity': 1,
      'description': 'sample desc',
      //add
      'category': 'Food'
    },
  ];

  CartProductsController() {}

  getProducts() {
    return cartProducts.sublist(1);
  }

  // addProductToCart(int _id, String _name, String _imageURL, String _description,
  //     String _category, double _price) {
  //   cartProducts.add({
  //     'id': _id,
  //     'name': _name,
  //     'image': _imageURL,
  //     'description': _description,
  //     'category': _category,
  //     'price': _price
  //   });
  // }

  incrementProductQuantity(String _name) {
    for (var i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i]["name"] == _name) {
        int currentQuantity = cartProducts[i]["quantity"] as int;
        cartProducts[i]["quantity"] = currentQuantity + 1;
        return;
      }
    }
  }

  decrementProductQuantity(String _name) {
    for (var i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i]["name"] == _name) {
        int currentQuantity = cartProducts[i]["quantity"] as int;
        if (currentQuantity > 1)
          cartProducts[i]["quantity"] = currentQuantity - 1;
        return;
      }
    }
  }

  addProductToCart(int _id, String _name, String _imageURL, double _price,
      double _quantity, String _description, String _category) {
    for (var i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i]["name"] == _name) {
        //ToDo: if name/id exists in cart, update its quantity and return;
        print("updating: " + _name);
        // cartProducts[i]["name"] = _name + "UPDATED";
        int currentQuantity = cartProducts[i]["quantity"] as int;
        cartProducts[i]["quantity"] = currentQuantity + 1;
        print(cartProducts[i]["quantity"]);
        return;
      }
    }

    cartProducts.add({
      'id': _id,
      'name': _name,
      'imageUrl': _imageURL,
      'price': _price,
      'quantity': _quantity,
      'description': _description,
      'category': _category
    });
    //cartProducts.add({'name': _name, 'imageUrl': _imageURL, 'price': _price});
  }

  getTotal() {
    int total = 0;
    for (var i = 0; i < cartProducts.sublist(1).length; i++) {
      // print(cartProducts.sublist(1)[i]["price"].toString() *
      //     cartProducts.sublist(1)[i]["quantity"]);
      //if (int.parse(cartProducts.sublist(1)[i]["quantity"].toString()) > 1) {}

      //total += cartProducts.sublist(1)[i]["price"];
      //print(cartProducts.sublist(1)[i]["price"].runtimeType);

      total += int.parse(cartProducts.sublist(1)[i]["price"].toString()) *
          int.parse(cartProducts.sublist(1)[i]["quantity"].toString());

      //total += cartProducts.sublist(1)[i]["price"];
    }
    return total;
    //cartProducts.add({'name': _name, 'imageUrl': _imageURL, 'price': _price});
  }

  clearCart() {
    cartProducts = [
      {
        'id': 9999999,
        'name': 'sample Product',
        'imageUrl': 'images/product_images/iphone.jpg',
        'price': 400,
        'quantity': 1,
        'description': 'sample desc',
        //add
        'category': 'Food'
      },
    ];
  }

  //todo: remove product using productId
  void removeProductFromCart(String productName) {
    cartProducts.removeWhere((product) => product["name"] == productName);
  }
}
