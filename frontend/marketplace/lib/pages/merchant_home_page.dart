import 'package:flutter/material.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';

class MerchantHomePage extends StatefulWidget {
  const MerchantHomePage({Key key}) : super(key: key);

  @override
  State<MerchantHomePage> createState() => _MerchantHomePageState();
}

class _MerchantHomePageState extends State<MerchantHomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: PageTitles.merchant_home_page,
      body: Center(
        child: Text('This is the merchant home page'),
      ),
    );
  }
}
