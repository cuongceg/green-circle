import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/widgets/e_commerce/product_widgets/add_cart.dart';
import 'package:green_circle/widgets/e_commerce/product_widgets/product_info.dart';
import 'package:provider/provider.dart';
import '../../models/cart_item.dart';
import '../../widgets/e_commerce/product_widgets/coupon_card.dart';
import '../../widgets/e_commerce/product_widgets/image_slider.dart';
import 'package:badges/badges.dart'as badges;
import 'package:green_circle/services/share_link.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

import 'cart_items.dart';


class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>with SingleTickerProviderStateMixin{
  int currentImageIndex = 0;
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.only(left:10),
                      ),
                      icon: const Icon(Icons.chevron_left,size:40,),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: ()async{
                        Uri link=await DynamicLinkService.instance.createDynamicLink();
                        Share.share("Shopping product:$link/id_product=1/");
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(15),
                      ),
                      icon: const Icon(Icons.share,size:30,),
                    ),
                    const SizedBox(width: 5),
                    Consumer<ProductProvider>(
                      builder: (context,productProvider,child){
                        bool isFav = widget.product.isFavorite;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                isFav?Icons.favorite:Icons.favorite_border_rounded,
                                color: isFav?Colors.redAccent:Colors.black,
                                size: 30,
                              ),
                              onPressed: (){
                                productProvider.toggleFavoriteStatus(widget.product.title);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 5),
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
              ),
              ImageSlider(
                  onChange: (index) {
                    setState(() {
                      currentImageIndex = index;
                    });
                  },
                  currentImage: currentImageIndex,
                  image: widget.product.image,
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.product.image.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: currentImageIndex == index ? 15 : 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: currentImageIndex == index
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
                subtitle:Text(widget.product.category.location??"In Ha Noi",style:const TextStyle(fontSize:12,color:Colors.grey),),
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