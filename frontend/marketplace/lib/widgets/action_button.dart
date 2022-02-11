import 'package:flutter/material.dart';
import 'package:marketplace/constants/constants.dart';
import 'package:marketplace/constants/route_names.dart';

Widget actionButton(BuildContext context, String text) {
  return new GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.home);
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.home);
            },
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ));
}
