import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/widgets/product_widgets/image_slider.dart';
import 'package:green_circle/widgets/product_widgets/product_info.dart';
import 'package:green_circle/widgets/product_widgets/product_desc.dart';
import 'package:green_circle/widgets/product_widgets/add_cart.dart';
import 'package:green_circle/widgets/product_widgets/appbar.dart';
import 'package:coupon_uikit/coupon_uikit.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>{
  int currentImage = 0;
  int currentNumber = 1;
  bool onSave=false;

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
                tag: widget.product.title,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductInfo(product: widget.product),
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
                      title:Text(widget.product.category.title,style:const TextStyle(fontSize:20,color:Colors.black),),
                      subtitle:const Text("In Ha Noi",style:TextStyle(fontSize:12,color:Colors.grey),),
                      trailing:TextButton(
                        child:const Text("Explore shop",style:TextStyle(color:green1),),
                        onPressed:(){},
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal:10,vertical:10),
                      child: Text("Shop voucher:",style:TextStyle(fontSize:18,color:green1,fontWeight: FontWeight.bold),),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:Row(
                        children: [
                          couponCard(),
                          couponCard(),
                          couponCard(),
                          couponCard(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color:mediumGray,
                      thickness: 5,
                    ),
                    ProductDescription(text: widget.product.description),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget couponCard(){
    return Padding(
      padding: const EdgeInsets.only(left:10,right:10,bottom:5),
      child: CouponCard(
        firstChild:const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Discount 20% max discount 150.000 VND",style:TextStyle(fontSize:15,fontWeight:FontWeight.w600,color: Colors.black),),
            Text("12/2/2024-20/2/2004",style:TextStyle(fontSize:12,color:Colors.grey),)
          ],
        ),
        secondChild:Container(
          decoration: BoxDecoration(
            color: onSave?Colors.white:green4,
            border: Border.all(color:onSave?green4:Colors.white)
          ),
          height: 35,
          width: 80,
          child: Center(
            child: TextButton(
              child:Text(onSave?"Use it":'Save',style:TextStyle(color:onSave?green4:Colors.white,fontSize:13),),
              onPressed:(){
                setState(() {
                  onSave=true;
                });
              },
            ),
          ),
        ),
        width:240,
        height:80,
        curvePosition:140,
        curveAxis: Axis.vertical,
        border:const BorderSide(color: green1),
      ),
    );
  }
}