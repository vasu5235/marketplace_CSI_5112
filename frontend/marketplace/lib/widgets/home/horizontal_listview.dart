import 'package:flutter/material.dart';

class HorizontalList extends StatefulWidget {
  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  var category_list = [
    {
      "image_location": "images/category_images/01.png",
      "image_caption": "Cloth"
    },
    {
      "image_location": "images/category_images/02.png",
      "image_caption": "Electronics"
    },
    {
      "image_location": "images/category_images/03.png",
      "image_caption": "Food"
    },
    {
      "image_location": "images/category_images/04.png",
      "image_caption": "Sports"
    },
    {
      "image_location": "images/category_images/05.png",
      "image_caption": "Books"
    },
    {
      "image_location": "images/category_images/06.png",
      "image_caption": "Health Care"
    },
    {
      "image_location": "images/category_images/07.png",
      "image_caption": "Category"
    },
    {
      "image_location": "images/category_images/08.png",
      "image_caption": "Category-2"
    }
  ];
  @override
  Widget build(BuildContext context) {

    // ListView of 
    return Container(
        height: 100.0,
        child: RawScrollbar(
          thickness: 5,
          isAlwaysShown: true,
          thumbColor: Colors.grey,
          radius: Radius.circular(20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category_list.length,
            itemBuilder: (context, index) {
              return Category(
                  image_location: category_list[index]['image_location'],
                  image_caption: category_list[index]['image_caption']);
            },
          ),
        ));
  }
}

class Category extends StatelessWidget {
  final image_location;
  final image_caption;

  Category({this.image_caption, this.image_location});
  
  // Product Card for GridView using ListTile
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 0,
      //width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5) //
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
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      image_caption,
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  ))),
        ),
      ),
    );
  }
}
