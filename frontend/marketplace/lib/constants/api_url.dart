class ApiUrl {
  static const String envUrl = "https://localhost:7136/api";
  //API calls related constants
  static const String get_category = envUrl + '/Category';
  static const String get_recent_product = envUrl + '/Product';
  static const String get_product_by_id = envUrl + '/Product/';
  static const String get_my_orders = envUrl + '/Order';
  static const String get_product_by_category = envUrl + '/Product/search-cat/';
  static const String checkout = envUrl + '/Order?id=';
}
