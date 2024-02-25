import 'production.dart';

class CartItem {
  int quantity;
  Product product;

  CartItem({
    required this.quantity,
    required this.product,
  });
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: json['product'],
      quantity: json['quantity'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'quantity': quantity,
    };
  }
}

List<CartItem> cartItems = [
  CartItem(quantity: 2, product: products[0]),
  CartItem(quantity: 1, product: products[1]),
];