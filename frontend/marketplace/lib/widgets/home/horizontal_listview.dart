import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marketplace/pages/category_filtered_products_page.dart';
import '../../constants/api_url.dart';
import 'dart:convert';

class HorizontalList extends StatefulWidget {
  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class User {
  final String imageURL, name;
  User(this.imageURL, this.name);
}

class _HorizontalListState extends State<HorizontalList> {
  Future getCategoryList() async {
    var response = await http.get(Uri.parse(ApiUrl.edit_category));

    var jsonData = jsonDecode(response.body);

    print(jsonData);
    return jsonData;
  }

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
          child: FutureBuilder(
            future: getCategoryList(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Category(
                        id: snapshot.data[index]['id'],
                        image_location: snapshot.data[index]['imageURL'],
                        image_caption: snapshot.data[index]['name']);
                  },
                );
            },
          ),
        ));
  }
}
//   Widget build(BuildContext context) {
//     // ListView of
//     return Container(
//         height: 100.0,
//         child: RawScrollbar(
//           thickness: 5,
//           isAlwaysShown: true,
//           thumbColor: Colors.grey,
//           radius: Radius.circular(20),
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: category_list.length,
//             itemBuilder: (context, index) {
//               return Category(
//                   image_location: category_list[index]['image_location'],
//                   image_caption: category_list[index]['image_caption']);
//             },
//           ),
//         ));
//   }
// }

class Category extends StatelessWidget {
  final id;
  final image_location;
  final image_caption;

  Category({this.id, this.image_caption, this.image_location});

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
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryFilteredProductsPage(
                    id, image_caption, image_location),
              ));
        },
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
