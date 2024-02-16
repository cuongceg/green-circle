import 'package:flutter/material.dart';
import 'package:green_circle/models/category.dart';

class Product {
  double price,rate;
  int likedNumber,purchasesNumber;
  bool onSale;
  final String title,description;
  final List<String> image;
  final List<Color> colors;
  final Category category;

  Product({
    required this.likedNumber,
    required this.purchasesNumber,
    required this.onSale,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.colors,
    required this.category,
    required this.rate,
  });
}

final List<Product> products = [
  Product(
    likedNumber: 300,
    purchasesNumber: 150,
    title: "Wireless Headphones",
    onSale: false,
    description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: ["assets/images/wireless.png","assets/images/wireless.png","assets/images/wireless.png","assets/images/wireless.png","assets/images/wireless.png"],
    price: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: categories[0],
    rate: 4.8,
  ),
  Product(
    likedNumber: 300,
    purchasesNumber: 150,
    title: "Woman Sweater",
    onSale: false,
    description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image:["assets/images/sweet.png","assets/images/sweet.png","assets/images/sweet.png","assets/images/sweet.png","assets/images/sweet.png"],
    price: 120,
    colors: [
      Colors.brown,
      Colors.red,
      Colors.pink,
    ],
    category: categories[1],
    rate: 4.8,
  ),
  Product(
    likedNumber: 300,
    purchasesNumber: 150,
    title: "Smart Watch",
    onSale: false,
    description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: ["assets/images/miband.png","assets/images/miband.png","assets/images/miband.png","assets/images/miband.png","assets/images/miband.png"],
    price: 55,
    colors: [
      Colors.black,
    ],
    category: categories[2],
    rate: 4.8,
  ),
];