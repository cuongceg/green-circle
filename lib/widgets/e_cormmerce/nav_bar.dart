import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/screen/e_cormmerce/home.dart';
import 'package:badges/badges.dart' as badges;
import 'package:green_circle/screen/e_cormmerce/search_screen.dart';
import 'package:green_circle/screen/screen_options.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            forceMaterialTransparency:true,
            leading:IconButton(
              icon: const Icon(Icons.arrow_back,size: 30,),
              onPressed:(){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const ScreenOptions()));
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search,size: 30,),
                onPressed:(){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const SearchScreen()));
                },
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