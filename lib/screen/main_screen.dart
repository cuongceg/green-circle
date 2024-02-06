import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/screen/cart.dart';
import 'package:green_circle/widgets/nav_bar.dart';

// TODO(cuongceg): change the size in bottom navigator bar.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  List screens = const [
    NavBar(),
    Scaffold(),
    Scaffold(),
    CartScreen(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentTab = 2;
          });
        },
        shape: const CircleBorder(),
        backgroundColor: green4,
        child: Image.asset("assets/images/scan_icon.png",height:30,width:30,color: Colors.white,)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:BottomAppBar(
        elevation: 0,
        height: 70,
        color: lightGray,
        shape: const CircularNotchedRectangle(),
        shadowColor: mediumGray,
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => setState(() {
                currentTab = 0;
              }),
              icon: Icon(
                Icons.home,
                size: 25,
                color: currentTab == 0 ? green1 : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                currentTab = 1;
              }),
              icon: Icon(
                Icons.support_agent,
                size: 25,
                color: currentTab == 1 ? green1 : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                currentTab = 3;
              }),
              icon: Icon(
                Icons.favorite_border_rounded,
                size: 25,
                color: currentTab == 3 ? green1 : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                currentTab = 4;
              }),
              icon: Icon(
                Icons.person,
                size: 25,
                color: currentTab == 4 ? green1 : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }
  // overflowed size
  // Widget labelIcon(IconData icon,int selectedTab,String label){
  //   return SizedBox(
  //     height:40,
  //     child: Expanded(
  //       child: Column(
  //         mainAxisAlignment:MainAxisAlignment.start,
  //         children: [
  //           IconButton(
  //             onPressed: () => setState(() {
  //               currentTab = selectedTab;
  //             }),
  //             icon: Icon(
  //               icon,
  //               size: 25,
  //               color: currentTab == selectedTab ? green1 : Colors.grey.shade400,
  //             ),
  //           ),
  //           Text(label,style:GoogleFonts.almarai(
  //               fontWeight:currentTab == selectedTab ? FontWeight.w700: FontWeight.w300,
  //             color: currentTab == selectedTab ? green1 : Colors.grey.shade400,
  //             fontSize: currentTab == selectedTab ? 15 : 12,
  //           ),)
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
