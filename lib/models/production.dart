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


final List<Product> products = [
  Product(
    likedNumber: 300,
    purchasesNumber: 150,
    productId: "123456789",
    label:"Technology",
    title: "Wireless Headphones",
    onSale: false,
    description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: ["assets/images/wireless.png","assets/images/wireless.png","assets/images/wireless.png","assets/images/wireless.png","assets/images/wireless.png"],
    price: 120,
    category: categories[0],
    rate: 4.8,
      remain: 1000
  ),
  Product(
      likedNumber: 300,
      purchasesNumber: 150,
      productId:'123456798',
      title: "Woman Sweater",
      label: "Clothes",
      onSale: false,
      description:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image:["assets/images/sweet.png","assets/images/sweet.png","assets/images/sweet.png","assets/images/sweet.png","assets/images/sweet.png"],
      price: 120,
      category: categories[1],
      rate: 4.8,
      remain: 1000
  ),
  Product(
      productId:'123456987',
      likedNumber: 300,
      purchasesNumber: 150,
      title: "Smart Watch",
      label: 'Technology',
      onSale: false,
      description:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: ["assets/images/miband.png","assets/images/miband.png","assets/images/miband.png","assets/images/miband.png","assets/images/miband.png"],
      price: 55,
      category: categories[2],
      rate: 4.8,
      remain: 1000
  ),
];