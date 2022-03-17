import 'package:flutter/material.dart';

const APP_NAME = 'Shoppers';

const APP_BAR_COLOR = Colors.indigo;

// Primary color used by forms
Color kPrimaryColor = APP_BAR_COLOR;

// Used in start.dart
enum Option { LogIn, SignUp }

// Used in orders_page.dart
var SAMPLE_ORDERS = [
  [
    {
      'name': 'iPhone 123',
      'image': 'images/product_images/iphone.jpg',
      'price': 400
    },
    {
      'name': 'iPhone 321',
      'image': 'images/product_images/iphone.jpg',
      'price': 800
    },
  ],
  [
    {
      'name': 'iPhone 0',
      'image': 'images/product_images/iphone.jpg',
      'price': 400
    },
    {
      'name': 'iPhone 1',
      'image': 'images/product_images/iphone.jpg',
      'price': 800
    },
    {
      'name': 'iPhone 2',
      'image': 'images/product_images/iphone.jpg',
      'price': 900
    },
  ],
  [
    {
      'name': 'iPhone 0',
      'image': 'images/product_images/iphone.jpg',
      'price': 400
    },
    {
      'name': 'iPhone 1',
      'image': 'images/product_images/iphone.jpg',
      'price': 800
    },
    {
      'name': 'iPhone 2',
      'image': 'images/product_images/iphone.jpg',
      'price': 900
    },
  ],
  [
    {
      'name': 'iPhone 0',
      'image': 'images/product_images/iphone.jpg',
      'price': 400
    },
    {
      'name': 'iPhone 1',
      'image': 'images/product_images/iphone.jpg',
      'price': 800
    },
    {
      'name': 'iPhone 2',
      'image': 'images/product_images/iphone.jpg',
      'price': 900
    },
  ],
  [
    {
      'name': 'iPhone 0',
      'image': 'images/product_images/iphone.jpg',
      'price': 400
    },
    {
      'name': 'iPhone 1',
      'image': 'images/product_images/iphone.jpg',
      'price': 800
    },
    {
      'name': 'iPhone 2',
      'image': 'images/product_images/iphone.jpg',
      'price': 900
    },
  ],
  [
    {
      'name': 'iPhone 0',
      'image': 'images/product_images/iphone.jpg',
      'price': 400
    },
    {
      'name': 'iPhone 1',
      'image': 'images/product_images/iphone.jpg',
      'price': 800
    },
    {
      'name': 'iPhone 2',
      'image': 'images/product_images/iphone.jpg',
      'price': 900
    },
  ]
];

// Used in cart_products.dart
var SAMPLE_CART_PRODUCTS = [
  {
    'name': 'iPhone 123',
    'image': 'images/product_images/iphone.jpg',
    'price': 400
  },
  {
    'name': 'iPhone 13',
    'image': 'images/product_images/iphone.jpg',
    'price': 400
  },
  {
    'name': 'iPhone 13',
    'image': 'images/product_images/iphone.jpg',
    'price': 400
  },
  {
    'name': 'iPhone 13',
    'image': 'images/product_images/iphone.jpg',
    'price': 400
  },
  {
    'name': 'iPhone 13',
    'image': 'images/product_images/iphone.jpg',
    'price': 400
  },
  {
    'name': 'iPhone 13',
    'image': 'images/product_images/iphone.jpg',
    'price': 400
  },
  {
    'name': 'iPhone 13',
    'image': 'images/product_images/iphone.jpg',
    'price': 400
  },
  {
    'name': 'iPhone 13',
    'image': 'images/product_images/iphone.jpg',
    'price': 400
  },
  {
    'name': 'iPhone 13',
    'image': 'images/product_images/iphone.jpg',
    'price': 400
  },
  {
    'name': 'iPhone 14',
    'image': 'images/product_images/iphone.jpg',
    'price': 200
  },
];

//used in discussion_forums_page.dart
var SAMPLE_QUESTIONS = [
  {
    'questionId': 1,
    'questionTitle': 'First Question',
    'questionDescription':
        'A suit of armor provides excellent sun protection on hot days.',
    'questionUserName': "Vasu Mistry",
  },
  {
    'questionId': 2,
    'questionTitle': 'Second Question',
    'questionDescription':
        'A suit of armor provides excellent sun protection on hot days.',
    'questionUserName': "Vasu Mistry",
  },
  {
    'questionId': 3,
    'questionTitle': 'Third Question',
    'questionDescription':
        'A suit of armor provides excellent sun protection on hot days.',
    'questionUserName': "Vasu Mistry",
  },
  {
    'questionId': 4,
    'questionTitle': 'Fourth Question',
    'questionDescription':
        'A suit of armor provides excellent sun protection on hot days.',
    'questionUserName': "Vasu Mistry",
  },
  {
    'questionId': 5,
    'questionTitle': 'Fifth Question',
    'questionDescription':
        'A suit of armor provides excellent sun protection on hot days.',
    'questionUserName': "Vasu Mistry",
  },
  {
    'questionId': 6,
    'questionTitle': 'Sixth Question',
    'questionDescription':
        'A suit of armor provides excellent sun protection on hot days.',
    'questionUserName': "Vasu Mistry",
  },
];

var SAMPLE_ANSWERS_DF2 = [
  {
    'questionId': 1,
    'questionTitle': 'bnFirst Question',
    'questionDescription':
        'A suit of armor provides excellent sun protection on hot days.',
    'questionUserName': "Vasu Mistry",
  },
  {
    'questionId': 2,
    'questionTitle': 'Second Question',
    'questionDescription':
        'A suit of armor provides excellent sun protection on hot days.',
    'questionUserName': "Vasu Mistry",
  },
  {
    'questionId': 3,
    'questionTitle': 'Third Question',
    'questionDescription':
        'A suit of armor provides excellent sun protection on hot days.',
    'questionUserName': "Vasu Mistry",
  },
  {
    'questionId': 4,
    'questionTitle': 'Fourth Question',
    'questionDescription':
        'A suit of armor provides excellent sun protection on hot days.',
    'questionUserName': "Vasu Mistry",
  },
];
