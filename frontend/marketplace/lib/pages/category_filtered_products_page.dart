import 'package:flutter/material.dart';

import '../widgets/app_scaffold.dart';

class CategoryFilteredProductsPage extends StatefulWidget {
  final String _categoryName;

  const CategoryFilteredProductsPage(this._categoryName, {Key key})
      : super(key: key);

  @override
  State<CategoryFilteredProductsPage> createState() =>
      _CategoryFilteredProductsPageState();
}

class _CategoryFilteredProductsPageState
    extends State<CategoryFilteredProductsPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: "Browse ${widget._categoryName} on Shoppers",
      body: Center(
        child: Text(widget._categoryName),
      ),
    );
  }
}
