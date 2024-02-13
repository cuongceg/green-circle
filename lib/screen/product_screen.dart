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
  int currentColor = 0;
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
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
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
                      padding: EdgeInsets.symmetric(horizontal:10,vertical:5),
                      child: Text("Shop voucher",style:TextStyle(fontSize:15,color:Colors.black,fontWeight: FontWeight.bold),),
                    ),
                    CouponCard(
                      firstChild:Container(color: Colors.red,),
                      secondChild:Text("13/2-14/2"),
                      width:200,
                      height:80,
                      curveAxis: Axis.vertical,

                      border:BorderSide(color: green1),
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child:Row(
                    //     children: [
                    //       CouponCard(firstChild:Container(color: Colors.red,), secondChild:Text("13/2-14/2"))
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 20),
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
}