import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/screen/product_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isHorizontal;//horizontal or vertical
  const ProductCard({super.key, required this.product,required this.isHorizontal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductScreen(product: product),
          ),
        );
      },
      child:Stack(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Image.asset(
                  product.image,
                  width: 120,
                  height: 120,
                ),
                Text(
                  product.title,
                  style:titleProduct
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "\$${product.price}",
                      style: price
                    ),
                    Row(
                      children: List.generate(
                        product.colors.length,
                            (cindex) => Container(
                          height: 15,
                          width: 15,
                          margin: const EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            color: product.colors[cindex],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: green1,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: const Icon(
                  Icons.heart_broken,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}