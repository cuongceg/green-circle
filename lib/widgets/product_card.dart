import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/screen/product_screen.dart';
import 'package:badges/badges.dart';

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
      child:isHorizontal?Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height:160,
          width: 160,
          decoration: BoxDecoration(
              border:Border.all(color:mediumGray,width: 2.0),
              borderRadius:BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: product.title,
                child: Image.asset(
                  product.image,
                  width: 150,
                  height: 95,
                ),
              ),
              const Divider(),
              Text(product.title,style:titleProduct,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:8,horizontal:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${product.price}",style:price,),
                    IconButton(
                        onPressed:(){},
                        icon: const Icon(Icons.favorite_border_rounded)
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ):Padding(
        padding: const EdgeInsets.only(left:10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color:mediumGray,width: 1.0),
            boxShadow:[
              BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(2, 4),
            )]
          ),
          child: Column(
            children: [
              Image.asset(
                product.image,
                width: 170,
                height: 125,
              ),
              Text(product.title, style:titleProduct),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Text(
                          "\$${product.price}",
                          style: price
                      ),
                    ),
                    IconButton(
                        onPressed:(){},
                        icon: Image.asset("assets/images/heart_icon.png",height:30,width:30,)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}