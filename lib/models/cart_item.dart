import 'package:flutter/material.dart';

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

class CartItemProvider with ChangeNotifier{
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  void addCartItem(CartItem cartItem){
    _cartItems.add(cartItem);
    notifyListeners();
  }

  void removeCartItem(CartItem cartItem){
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  void clearCart(){
    _cartItems.clear();
    notifyListeners();
  }
}
