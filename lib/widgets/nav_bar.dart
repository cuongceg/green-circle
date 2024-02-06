import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/screen/home.dart';

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
            title:IconButton(
              icon: Image.asset("assets/images/menus_icon.png",height:40,width:40,),
              onPressed:(){},
            ),
            actions: [
              IconButton(
                icon: Image.asset("assets/images/search_icon.png",height:30,width:30,),
                onPressed:(){},
              ),
              IconButton(
                icon: Image.asset("assets/images/notification_icon.png",height:30,width:30,),
                onPressed:(){},
              ),
              IconButton(
                icon: Image.asset("assets/images/cart_icon.png",height:30,width:30,),
                onPressed:(){},
              ),
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
                        child:Text("Voucher"),
                      )
                  ),
                  Tab(
                      child:Center(
                        child:Text("Sale"),
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