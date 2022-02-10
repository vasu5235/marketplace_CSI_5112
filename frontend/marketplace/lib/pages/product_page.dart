import 'package:flutter/material.dart';
import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: PageTitles.product,
      body: const Center(
        child: Text('This is the product page'),
      ),
    );
  }
}
