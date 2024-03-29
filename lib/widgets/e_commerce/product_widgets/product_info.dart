import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';

class ProductInfo extends StatelessWidget {
  final Product product;
  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical:5,horizontal:15),
          child: Text(
            "${product.price.toStringAsFixed(0)} 000",
            style: price1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:13),
          child: Text(
            product.title,
            style:titleProduct,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:10,horizontal:10),
          child: Row(
            children: [
              Container(
                width: 75,
                height: 20,
                decoration: BoxDecoration(
                  color: green1,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 1,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 13,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "${product.rate} /5.0",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width:15),
              Text(
                "Sold ${product.purchasesNumber} products",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}