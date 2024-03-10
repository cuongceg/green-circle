import 'package:green_circle/models/category.dart';
import 'package:hive/hive.dart';

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
class FavorProducts extends HiveObject{
  @HiveField(0)
  String imageUrl;
  @HiveField(1)
  double price;
  @HiveField(2)
  String productId;
  @HiveField(3)
  String title;
  @HiveField(4)
  int favorNumbers;
  FavorProducts({required this.productId,required this.price,required this.imageUrl,required this.title,required this.favorNumbers});
}

class FavorProductsAdapter extends TypeAdapter<FavorProducts> {
  @override
  final int typeId = 0; // Unique identifier for the type

  @override
  FavorProducts read(BinaryReader reader) {
    return FavorProducts(
      productId: reader.readString(),
      price: reader.readDouble(),
      imageUrl: reader.readString(),
      title: reader.readString(),
      favorNumbers: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, FavorProducts obj) {
    writer.writeString(obj.productId);
    writer.writeDouble(obj.price);
    writer.writeString(obj.imageUrl);
    writer.writeString(obj.title);
    writer.writeInt(obj.favorNumbers);
  }
}

class CartItems extends HiveObject{
  @HiveField(0)
  String imageUrl;
  @HiveField(1)
  double price;
  @HiveField(2)
  String productId;
  @HiveField(3)
  String title;
  @HiveField(4)
  int quantity;
  CartItems({required this.productId,required this.price,required this.imageUrl,required this.title,required this.quantity});
}

class CartItemsAdapter extends TypeAdapter<CartItems> {
  @override
  final int typeId = 1; // Unique identifier for the type

  @override
  CartItems read(BinaryReader reader) {
    return CartItems(
      productId: reader.readString(),
      price: reader.readDouble(),
      imageUrl: reader.readString(),
      title: reader.readString(),
      quantity: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, CartItems obj) {
    writer.writeString(obj.productId);
    writer.writeDouble(obj.price);
    writer.writeString(obj.imageUrl);
    writer.writeString(obj.title);
    writer.writeInt(obj.quantity);
  }
}