import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:badges/badges.dart'as badges;
import 'package:green_circle/models/production.dart';
import 'package:green_circle/widgets/e_commerce/product_card.dart';
import 'package:provider/provider.dart';

import '../../models/cart_item.dart';
import 'cart_items.dart';

class LikeProductScreen extends StatefulWidget {
  const LikeProductScreen({super.key});

  @override
  State<LikeProductScreen> createState() => _LikeProductScreenState();
}

class _LikeProductScreenState extends State<LikeProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency:true,
        title: Text("My likes",style:title2Black,),
        actions: [
          IconButton(
            icon: const Icon(Icons.search,size: 30,),
            onPressed:(){
            },
          ),
          Consumer<CartItemProvider>(
            builder: (context,cartItemProvider,child){
              final carts= cartItemProvider.cartItems;
              return badges.Badge(
                position: badges.BadgePosition.topEnd(top: 0, end: 2),
                badgeAnimation: const badges.BadgeAnimation.slide(
                  // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
                  // curve: Curves.easeInCubic,
                ),
                showBadge: true,
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: green1,
                ),
                badgeContent:Text(
                  "${carts.length}",
                  style: const TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined,size:25,),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => const CartScreen()));
                    }),
              );
            },
          )
        ],
      ),
      body:Consumer<ProductProvider>(
        builder: (context,productProvider,child){
          final favProducts=productProvider.products.where((element) => element.isFavorite==true).toList();
          return ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio:0.95,
                ),
                itemCount: favProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: productProvider.products[index], isHorizontal: false);
                },
              ),
            ],
          );
        },
      )
    );
  }
}
