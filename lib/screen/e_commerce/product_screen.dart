import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/screen/e_commerce/cart_items.dart';
import 'package:green_circle/services/database.dart';
import 'package:green_circle/widgets/e_commerce/product_widgets/add_cart.dart';
import 'package:green_circle/widgets/e_commerce/product_widgets/product_info.dart';
import 'package:hive/hive.dart';
import '../../widgets/e_commerce/product_widgets/coupon_card.dart';
import '../../widgets/e_commerce/product_widgets/image_slider.dart';
import 'package:badges/badges.dart'as badges;
import 'package:green_circle/services/share_link.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';


class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>with SingleTickerProviderStateMixin{
  int currentImageIndex = 0;
  bool isFav = false;
  var box =Hive.box<FavorProducts>('favourite_products');
  var cart = Hive.box<CartItems>('cart_items');
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _colorAnimation = ColorTween(begin: mediumGray, end: Colors.red).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  // dismiss the animation when widget exits screen
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    debugPrint("dispose controller");
  }
  @override
  Widget build(BuildContext context) {
    int currentNumber = widget.product.likedNumber;
    int cartItems = cart.length;
    FavorProducts favorProducts=FavorProducts(
        productId: widget.product.productId,
        price: widget.product.price,
        imageUrl: widget.product.image[0],
        title: widget.product.title,
        favorNumbers: currentNumber+1);
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
                    AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, _){
                          return IconButton(
                            icon: Icon(
                              isFav?Icons.favorite:Icons.favorite_border_rounded,
                              color: _colorAnimation.value,
                              size: 30,
                            ),
                            onPressed: (){
                              isFav ? _controller.reverse() : _controller.forward();
                              if(isFav){
                                currentNumber;
                                box.deleteAt(box.length-1);
                              }
                              else{
                                currentNumber+=1;
                                box.add(favorProducts);
                              }
                              debugPrint("${box.length}");
                              Database().productionCollection.doc(widget.product.productId).update({"likedNumber":currentNumber});
                            },
                          );
                        }
                    ),
                    const SizedBox(width: 5),
                    badges.Badge(
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
                        "$cartItems",
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: IconButton(
                          icon: const Icon(Icons.shopping_cart_outlined),
                          onPressed: () {
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const CartScreen()));
                          }),
                    )],
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