import 'package:flutter/material.dart';

class HorizontaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
              image_location: 'images/category_images/01.jpg',
              image_caption: 'Cloth'),
          Category(
              image_location: 'images/category_images/02.jpg',
              image_caption: 'Cloth'),
          Category(
              image_location: 'images/category_images/03.jpg',
              image_caption: 'Cloth'),
          Category(
              image_location: 'images/category_images/04.jpg',
              image_caption: 'Cloth'),
          Category(
              image_location: 'images/category_images/05.jpg',
              image_caption: 'Cloth'),
          Category(
              image_location: 'images/category_images/06.jpg',
              image_caption: 'Cloth'),
          Category(
              image_location: 'images/category_images/06.jpg',
              image_caption: 'Cloth'),
          Category(
              image_location: 'images/category_images/06.jpg',
              image_caption: 'Cloth'),
          Category(
              image_location: 'images/category_images/06.jpg',
              image_caption: 'Cloth'),
          Category(
              image_location: 'images/category_images/06.jpg',
              image_caption: 'Cloth'),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({this.image_caption, this.image_location});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 0,
      //width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.all(Radius.circular(10) //
            ),
      ),
      padding: EdgeInsets.fromLTRB(10, 4, 10, 25),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
              title: Image.asset(
                image_location,
                width: 100.0,
                height: 80.0,
              ),
              subtitle: Container(
                padding: const EdgeInsets.all(5.0),
                alignment: Alignment.topCenter,
                child: Text(
                  image_caption,
                  style: new TextStyle(fontSize: 12.0),
                ),
              )),
        ),
      ),
    );
  }
}
