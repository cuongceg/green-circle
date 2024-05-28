import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/screen/e_commerce/home.dart';
import 'package:green_circle/screen/e_commerce/search_screen.dart';
import 'package:green_circle/models/production.dart';
import 'package:badges/badges.dart' as badges;
import 'package:hive/hive.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var box = Hive.box<CartItems>('cart_items');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            forceMaterialTransparency:true,
            title: GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const SearchScreen()));
              },
              child: Container(
                height: 40,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black87),
                ),
                child:Row(
                  children:[
                    const SizedBox(width: 10,),
                    const Icon(Icons.search,size:25,),
                    const SizedBox(width: 15,),
                    Text("Search something",style: GoogleFonts.almarai(fontSize:14,fontWeight:FontWeight.w400,color:Colors.grey),)
                  ]
                )
              ),
            ),
            actions: [
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
                  "${box.length}",
                  style: const TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined,size:25,),
                    onPressed: () {
                    }),
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
                  "0",
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    icon: Image.asset('assets/images/chat_icon.png',height:25,width: 25,),
                    onPressed: () {}),
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
                        child:Text("Flash sale"),
                      )
                  ),
                  Tab(
                      child:Center(
                        child:Text("Voucher"),
                      )
                  ),
                ]),
          ),
          body: const TabBarView(children: [
            HomeScreen(),
            Icon(Icons.movie),
            Icon(Icons.games),
          ]),
        ));
  }
}