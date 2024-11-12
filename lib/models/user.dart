import 'cart_item.dart';
import 'production.dart';

class MyUser{
  String uid;//unique user id from Firebase
  MyUser({required this.uid});
}

class UserInformation{
  String name;
  List<String>voucherId;
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

  UserInformation copyWith({
    String? name,
    List<String>? voucherId,
    String? imageUrl,
    List<CartItem>? cartItems,
    List<Product>? boughtProduct,
    List<Product>? likedProduct,
    List<Product>? soldProduct,
  }) {
    return UserInformation(
      name: name ?? this.name,
      voucherId: voucherId ?? this.voucherId,
      imageUrl: imageUrl ?? this.imageUrl,
      cartItems: cartItems ?? this.cartItems,
      boughtProduct: boughtProduct ?? this.boughtProduct,
      likedProduct: likedProduct ?? this.likedProduct,
      soldProduct: soldProduct ?? this.soldProduct,
    );
  }
}