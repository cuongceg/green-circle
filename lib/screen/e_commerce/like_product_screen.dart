import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:badges/badges.dart'as badges;
import 'package:green_circle/services/database.dart';
import 'package:hive/hive.dart';

class LikeProductScreen extends StatefulWidget {
  const LikeProductScreen({super.key});

  @override
  State<LikeProductScreen> createState() => _LikeProductScreenState();
}

class _LikeProductScreenState extends State<LikeProductScreen> {
  @override
  Widget build(BuildContext context) {
    var box =Hive.box<FavorProducts>('favourite_products');
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
              onPressed:(){
              },
            ),
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: 0, end: 2),
              badgeAnimation: const badges.BadgeAnimation.slide(
                disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
                curve: Curves.easeInCubic,
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
                disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
                curve: Curves.easeInCubic,
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
                    childAspectRatio:0.95,
                  ),
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(box.getAt(index)!.imageUrl,
                              width: 170,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:10,top: 0),
                              child: Text(box.getAt(index)!.title,style:body1Black,),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:const EdgeInsets.only(left:10.0),
                                  child: Text("${box.getAt(index)!.price.toStringAsFixed(0)} 000",style:body1Black,),
                                ),
                                TextButton.icon(
                                    onPressed:(){
                                      setState(() {
                                        int favourNumbers= box.getAt(index)!.favorNumbers;
                                        String productId= box.getAt(index)!.productId;
                                        box.deleteAt(index);
                                        // favourNumbers-=1;
                                        Database().productionCollection.doc(productId).update({"likedNumber":favourNumbers});
                                      });
                                    },
                                    icon: const Icon(Icons.favorite,color:Colors.red,),
                                    label: Text("${box.getAt(index)!.favorNumbers}",style:body1Black,)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
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
