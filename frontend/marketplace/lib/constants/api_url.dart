class ApiUrl {
  //local

  //static const String envUrl = "https://localhost:7136/api";
  //prod
  //static const String envUrl = "https://services.vlearnings.net/api";
  static const String envUrl = 'http://3.93.177.49/api';

  //API calls related constants
  static const String get_category = envUrl + '/Category';
  static const String get_recent_product = envUrl + '/Product';
  static const String get_product_by_id = envUrl + '/Product/';

  static const String get_all_orders = envUrl + '/Order';
  static const String get_orders_by_userid = envUrl + '/Order/byUser/';
  static const String get_product_by_category = envUrl + '/Product/search-cat/';

  //Discussion Forum
  static const String get_questions = envUrl + '/question';
  static const String get_answers = envUrl + '/answer';
  static const String checkout = envUrl + '/Order?id=';
  static const String search_by_product_name = envUrl + '/Product/search/';

  //Category
  static const String add_category = envUrl + '/Category';
  static const String edit_category = envUrl + '/Category';
  static const String delete_category = envUrl + '/Category/';

  //product
  static const String add_product = envUrl + '/Product';
  static const String edit_product = envUrl + '/Product';
  static const String delete_product = envUrl + '/Product/';

  //user
  static const String get_all_users = envUrl + '/User';
}
