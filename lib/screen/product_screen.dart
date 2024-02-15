import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/widgets/coupon_card.dart';
import 'package:green_circle/widgets/product_widgets/image_slider.dart';
import 'package:green_circle/widgets/product_widgets/product_info.dart';
import 'package:green_circle/widgets/product_widgets/add_cart.dart';
import 'package:green_circle/widgets/product_widgets/appbar.dart';
import 'package:readmore/readmore.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>{
  int currentImage = 0;
  int currentNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       floatingActionButton: AddToCart(
         product: widget.product,
       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductAppBar(cart:currentNumber,),
              Hero(
                tag: "${widget.product.title} sale",
                child: ImageSlider(
                  onChange: (index) {
                    setState(() {
                      currentImage = index;
                    });
                  },
                  currentImage: currentImage,
                  image: widget.product.image,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: currentImage == index ? 15 : 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: currentImage == index
                          ? Colors.black
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height:20),
              SizedBox(
                width: double.infinity,
                child: ProductInfo(product: widget.product),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton.icon(onPressed:(){}, icon:const Icon(Icons.reset_tv_outlined,color:green4,), label: const Text("Free returns",style:TextStyle(color:Colors.black),)),
                  TextButton.icon(onPressed:(){}, icon:const Icon(Icons.check_circle_outline,color:green4,), label: const Text("Genuine",style:TextStyle(color:Colors.black),)),
                  TextButton.icon(onPressed:(){}, icon:const Icon(Icons.local_shipping_outlined,color:green4,), label: const Text("Free delivery",style:TextStyle(color:Colors.black),))
                ],
              ),
              const Divider(
                color:mediumGray,
                thickness: 5,
              ),
              ListTile(
                contentPadding:const EdgeInsets.symmetric(vertical:5, horizontal:0),
                dense: true,
                visualDensity: const VisualDensity(horizontal:-4, vertical:-1),
                leading:CircleAvatar(
                  backgroundImage: AssetImage(widget.product.category.image),
                  radius:30,
                ),
                title:Text(widget.product.category.title,style:title2Black,),
                subtitle:const Text("In Ha Noi",style:TextStyle(fontSize:12,color:Colors.grey),),
                trailing:TextButton(
                  child:const Text("Explore shop",style:TextStyle(color:green1),),
                  onPressed:(){},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10,vertical:10),
                child: Text("Shop voucher:",style:title3,),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:Row(
                  children: [
                    Coupon(discountPercent: 15, maxDiscount: 150, outOfDate:DateTime.now()),
                    Coupon(discountPercent: 25, maxDiscount: 200, outOfDate:DateTime.now()),
                    Coupon(discountPercent: 50, maxDiscount: 300, outOfDate:DateTime.now()),
                    Coupon(discountPercent: 75, maxDiscount: 400, outOfDate:DateTime.now()),
                    Coupon(discountPercent: 80, maxDiscount: 500, outOfDate:DateTime.now()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                color:mediumGray,
                thickness: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10,vertical:10),
                child: Text("Product description:",style:title3,),
              ),
              ReadMoreText(
                "    ${widget.product.description}",
                trimLines: 2,
                trimMode: TrimMode.Line,
                style: body1Black,
                moreStyle: body1Green,
                lessStyle:body1Green,
              ),
              const SizedBox(height:80,)
            ],
          ),
        ),
      ),
    );
  }
}