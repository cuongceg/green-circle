import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/screen/e_commerce/product_screen.dart';

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
          width: 180,
          decoration: BoxDecoration(
              border:Border.all(color:mediumGray,width: 2.0),
              borderRadius:BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                  product.image[0],
                  width: 170,
                  height: 100,
                fit: BoxFit.contain,
                ),
              Padding(
                padding: const EdgeInsets.only(left:10,top: 0),
                child: Text(product.title,style:body1Black,),
              ),
              const SizedBox(height:5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:const EdgeInsets.only(left:10.0),
                    child: Text("${product.price.toStringAsFixed(0)} 000",style:body1Black,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Text("Sold ${product.purchasesNumber}",style:body1Black,),
                  ),
                ],
              ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.image[0],
                width: 170,
                height: 125,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: const EdgeInsets.only(left:10),
                child: Text(product.title, style:body1Black),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Text(
                          "${product.price.toStringAsFixed(0)} 000",
                          style: body1Black
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:10.0),
                      child: Text("Sold ${product.purchasesNumber}",style:body1Black,),
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