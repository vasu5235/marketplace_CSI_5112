import 'package:flutter/material.dart';

// class HorizontaListProducts extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 250.0,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: <Widget>[
//           Category(
//               image_location: 'images/01.jpeg',
//               image_caption: ''),
//           Category(
//               image_location: 'images/02.jpeg',
//               image_caption: ''),
//           Category(
//               image_location: 'images/03.jpeg',
//               image_caption: ''),
//           Category(
//               image_location: 'images/04.jpeg',
//               image_caption: ''),
//           Category(
//               image_location: 'images/05.jpeg',
//               image_caption: ''),
//           Category(
//               image_location: 'images/06.jpeg',
//               image_caption: ''),
//           // Category(
//           //     image_location: 'images/category_images/06.jpg',
//           //     image_caption: 'Cloth'),
//           // Category(
//           //     image_location: 'images/category_images/06.jpg',
//           //     image_caption: 'Cloth'),
//           // Category(
//           //     image_location: 'images/category_images/06.jpg',
//           //     image_caption: 'Cloth'),
//           // Category(
//           //     image_location: 'images/category_images/06.jpg',
//           //     image_caption: 'Cloth'),
//         ],
//       ),
//     );
//   }
// }
//
// class Category extends StatelessWidget {
//   final String image_location;
//   final String image_caption;
//
//   Category({this.image_caption, this.image_location});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       //height: 0,
//       //width: 150,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blueAccent),
//         borderRadius: BorderRadius.all(Radius.circular(10) //
//         ),
//       ),
//       padding: EdgeInsets.fromLTRB(50, 4, 50, 25),
//       margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
//       child: InkWell(
//         onTap: () {},
//         child: Container(
//           width: 100.0,
//           child: ListTile(
//               title: Image.asset(
//                 image_location,
//                 fit: BoxFit.fitHeight,
//               ),
//               subtitle: Container(
//                 padding: const EdgeInsets.all(5.0),
//                 alignment: Alignment.topCenter,
//                 child: Text(
//                   image_caption,
//                   style: new TextStyle(fontSize: 12.0),
//                 ),
//               )),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Test-1",
      "picture": "images/recent_images/01.jpeg",
      "old_price": 100,
      "price": 80,
    },
    {
      "name": "Test-2",
      "picture": "images/recent_images/02.jpeg",
      "old_price": 100,
      "price": 80,
    },
    {
      "name": "Test-3",
      "picture": "images/recent_images/03.jpeg",
      "old_price": 100,
      "price": 80,
    },
    {
      "name": "Test-4",
      "picture": "images/recent_images/04.jpeg",
      "old_price": 100,
      "price": 80,
    },
    {
      "name": "Test-5",
      "picture": "images/recent_images/05.jpeg",
      "old_price": 100,
      "price": 80,
    },
    {
      "name": "Test-6",
      "picture": "images/recent_images/06.jpeg",
      "old_price": 100,
      "price": 80,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
    child: RawScrollbar(
      thickness: 10,
      isAlwaysShown: true,
      thumbColor: Colors.grey,
      radius: Radius.circular(20),
      child: GridView.builder(
      //physics: NeverScrollableScrollPhysics(),
      //shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: product_list.length,
        gridDelegate:
        // new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, ),
        SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 200,
            // mainAxisSpacing: 20
        ),
        itemBuilder: (BuildContext context, int index) {
          return Single_prod(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
          );
        })));
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_prod(
      {this.prod_name,
        this.prod_old_price,
        this.prod_picture,
        this.prod_price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Hero(
          tag: prod_name,
          child: Material(
              child: InkWell(
                onTap: () {},
                child: GridTile(
                    footer: Container(
                      color: Colors.white70,
                      child: ListTile(
                        leading: Text(prod_name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0)),
                        trailing: Text(
                          "\$$prod_price",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    child: Image.asset(
                      prod_picture,
                      fit: BoxFit.cover,
                    )),
              ))),
    );
  }
}
