import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/widgets/home/horizontal_listview.dart';
import 'package:marketplace/widgets/home/products.dart';
//import 'package:marketplace/widgets/home/horizontal_listview_recentproducts.dart';

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
        body: new ListView(
          children: <Widget>[
            //image_carousel,
            new Padding(
                padding: const EdgeInsets.fromLTRB(22, 20, 0, 10),
                child: new Text(
                  "Categories",
                  style: new TextStyle(fontSize: 20.0),
                )),
            HorizontalList(),
            new Padding(
                padding: const EdgeInsets.fromLTRB(22, 30, 0, 10),
                child: new Text(
                  "Recent Products",
                  style: new TextStyle(fontSize: 20.0),
                )),
            Container(
              child: Products(),
            )
          ],
        ));
  }
}
