import 'package:flutter/material.dart';
import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';
import 'package:carousel_pro/carousel_pro.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/home/products.dart';
import '../widgets/home/horizontal_listview.dart';

//import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //=======================Carousel Code=====================
    Widget image_carousel = new Container(
        height: 250,
        child: new Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('images/carousel_images/01.jpeg'),
            AssetImage('images/carousel_images/02.jpeg'),
            AssetImage('images/carousel_images/03.jpeg'),
            AssetImage('images/carousel_images/04.jpeg')
          ],
          autoplay: true,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
        ),
        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(25.0));

    //=========================================================
    return AppScaffold(
        pageTitle: PageTitles.home,
        body: new ListView(
          children: <Widget>[
            image_carousel,
            new Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 0, 10),
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
        )
        // body: Center(
        //   child: Text('This is the home page'),
        // ),
        );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
      );
}
