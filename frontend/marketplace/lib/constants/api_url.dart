class ApiUrl {
  static const String envUrl = "https://localhost:7136/api";
  //API calls related constants
  static const String get_category = envUrl + '/Category';
  static const String get_recent_product = envUrl + '/Product';
  static const String get_product_by_id = envUrl + '/Product/';
  static const String get_all_orders = envUrl + '/Order';
  static const String get_orders_by_userid = envUrl + '/Order/byUser/';
  static const String get_product_by_category = envUrl + '/Product/search-cat/';
  static const String checkout = envUrl + '/Order?id=';
  static const String search_by_product_name = envUrl + '/Product/search/';
}
