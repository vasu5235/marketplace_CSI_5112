import 'package:flutter/material.dart';
import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/home/horizontal_listview_recentproducts.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        pageTitle: PageTitles.home,

        body: new ListView(

          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Card(
                      child: Image.asset("images/product_images/iphone13.png", height: 250, width: 250, fit: BoxFit.contain,),
                      elevation: 18.0,
                      shape: RoundedRectangleBorder(),
                      shadowColor: Colors.black,
                    )


                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("iPhone 13 Pro Max", style: TextStyle(fontSize: 18.0, fontFamily: 'Raleway', fontWeight: FontWeight.w700)),
                    Text("\n\$1500.00"),
                    Text("\nQuantity: 1"),
                    Text("\n\nOrder in next 1 Hour and get it by tomorrow\n\n"),
                    Row(

                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),

                      onPressed: () { },
                      child:
                      Text('Add to Cart'),
                    )
                  ],
                ),
                VerticalDivider(color: Colors.black,
                  thickness: 2, width: 20,
                  indent: 200,
                  endIndent: 200,),
                Container(height: 250, child: VerticalDivider(color: Colors.grey)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                    Text("\n\nAs part of our efforts to reach our environmental goals, \niPhone 13 Pro and iPhone 13 Pro Max do not include \na power adapter or EarPods. Included in the box is a USB‑C \nto Lightning Cable that supports fast charging and is \ncompatible with USB‑C power adapters and computer ports."),
                    Text("\n\nDimensions: 160.8 x 78.1 x 7.7 mm\nWeight: 240 g (8.47 oz)")
                  ],

                )

              ],
            ),
            new Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 0, 10),
                child: new Text(
                  "View More Products",
                  style: new TextStyle(fontSize: 20.0),
                )),
            Container(
              height: 320.0,
              child: Products(),
            )
          ],
        )
    );
  }
}
