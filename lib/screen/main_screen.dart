import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/screen/cart.dart';
import 'package:green_circle/widgets/nav_bar.dart';
import 'home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int currentTab = 2;
  List screens = const [
    NavBar(),
    Scaffold(),
    HomeScreen(),
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
        child: const Icon(
          Icons.home,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 70,
        color: lightGray,
        shape: const CircularNotchedRectangle(),
        shadowColor: mediumGray,
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => setState(() {
                currentTab = 0;
              }),
              icon: Icon(
                Icons.grid_4x4_rounded,
                color: currentTab == 0 ? green1 : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                currentTab = 1;
              }),
              icon: Icon(
                Icons.heart_broken,
                color: currentTab == 1 ? green1 : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                currentTab = 3;
              }),
              icon: Icon(
                Icons.shopping_cart,
                color: currentTab == 3 ? green1 : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                currentTab = 4;
              }),
              icon: Icon(
                Icons.person,
                color: currentTab == 4 ? green1 : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }
}