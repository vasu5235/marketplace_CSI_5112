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
