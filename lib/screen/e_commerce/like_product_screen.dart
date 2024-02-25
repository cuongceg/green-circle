import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/widgets/e_commerce/product_card.dart';
import 'package:badges/badges.dart'as badges;
import 'package:provider/provider.dart';

class LikeProductScreen extends StatefulWidget {
  const LikeProductScreen({super.key});

  @override
  State<LikeProductScreen> createState() => _LikeProductScreenState();
}

class _LikeProductScreenState extends State<LikeProductScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product>? productsInfo=Provider.of<List<Product>?>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          forceMaterialTransparency:true,
          title: Text("My likes",style:title2Black,),
          actions: [
            IconButton(
              icon: const Icon(Icons.search,size: 30,),
              onPressed:(){},
            ),
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: 0, end: 2),
              badgeAnimation: const badges.BadgeAnimation.slide(
              ),
              showBadge: true,
              badgeStyle: const badges.BadgeStyle(
                badgeColor: green1,
              ),
              badgeContent:const Text(
                "2",
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(icon: const Icon(Icons.notifications,size: 25,), onPressed: () {}),
            ),
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
              badgeContent:const Text(
                "5",
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(icon: const Icon(Icons.shopping_cart,size:25,), onPressed: () {}),
            )
          ],
          bottom: TabBar(
              labelColor:Colors.white,
              labelStyle: label,
              labelPadding: const EdgeInsets.symmetric(horizontal:10),
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color:green4
              ),
              tabs: const [
                Tab(
                    child:Center(
                      child:Text("All"),
                    )
                ),
                Tab(
                    child:Center(
                      child:Text("Discount"),
                    )
                ),
                Tab(
                    child:Center(
                      child:Text("Status"),
                    )
                ),
              ]),
        ),
        body:TabBarView(
          children: [
            ListView(
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
                    childAspectRatio:0.85,
                  ),
                  itemCount: productsInfo!.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: productsInfo[index],isHorizontal: false,);
                  },
                ),
              ],
            ),
            const Icon(Icons.movie),
            const Icon(Icons.games),
          ],
        ),
      ),
    );
  }
}
