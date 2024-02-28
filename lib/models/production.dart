import 'package:green_circle/models/category.dart';

class Product {
  double price, rate;
  int likedNumber, purchasesNumber,remain;
  bool onSale;
  final String title, description,label,productId;
  final List<String> image;
  final Category category;

  Product({
    required this.likedNumber,
    required this.purchasesNumber,
    required this.onSale,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
    required this.rate,
    required this.label,
    required this.productId,
    required this.remain
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    Category category = Category.fromJson(json['category']);

    return Product(
      price: json['price'],
      productId: json['productId'],
      rate: json['rate'],
      label: json['label'],
      likedNumber: json['likedNumber'],
      purchasesNumber: json['purchasesNumber'],
      onSale: json['onSale'],
      title: json['title'],
      description: json['description'],
      image: List<String>.from(json['image']),
      category: category,
      remain: json['remain']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'rate': rate,
      'likedNumber': likedNumber,
      'purchasesNumber': purchasesNumber,
      'onSale': onSale,
      'title': title,
      'description': description,
      'image': image,
      'category': category.toJson(),
    };
  }

}

