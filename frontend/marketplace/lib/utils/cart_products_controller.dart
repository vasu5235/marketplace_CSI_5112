class CartProductsController {
  static var cartProducts = [
    {
      'name': 'iPhone 123',
      'image': 'images/product_images/iphone.jpg',
      'price': 400
    },
    {
      'name': 'iPhone 13',
      'image': 'images/product_images/iphone.jpg',
      'price': 400
    },
  ];

  CartProductsController() {}

  getProducts() {
    return cartProducts;
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

  addProductToCart(String _name, String _imageURL, double _price) {
    for (var i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i]["name"] == _name) {
        cartProducts[i]["name"] = _name + "UPDATED";
        return;
      }
    }

    cartProducts.add({'name': _name, 'image': _imageURL, 'price': _price});
  }

  clearCart() {
    cartProducts = [];
  }

  //todo: remove product using productId
  void removeProductFromCart(String productName) {
    cartProducts.removeWhere((product) => product["name"] == productName);
  }
}
