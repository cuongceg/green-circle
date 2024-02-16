import 'cart_item.dart';
import 'production.dart';

class MyUser{
  String uid;//unique user id from Firebase
  MyUser({required this.uid});
}

class UserInformation{
  String name,voucherId;
  String? imageUrl;
  List<CartItem>? cartItems;
  List<Product>? boughtProduct;
  List<Product>? likedProduct;
  List<Product>? soldProduct;
  UserInformation({
  required this.name,
  required this.voucherId,
    this.imageUrl,
    this.cartItems,
    this.boughtProduct,
    this.likedProduct,
    this.soldProduct
  });
}