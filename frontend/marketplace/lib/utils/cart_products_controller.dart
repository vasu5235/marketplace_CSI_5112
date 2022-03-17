class CartProductsController {
  static var cartProducts = [
    {
      'id': 9999999,
      'name': 'sample Product',
      'image': 'images/product_images/iphone.jpg',
      'price': 400,
      'quantity': 1,
      'description': 'sample desc'
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
      double _quantity, String _description) {
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
      'image': _imageURL,
      'price': _price,
      'quantity': _quantity,
      'description': _description
    });
  }

  clearCart() {
    cartProducts = [];
  }

  //todo: remove product using productId
  void removeProductFromCart(String productName) {
    cartProducts.removeWhere((product) => product["name"] == productName);
  }
}
