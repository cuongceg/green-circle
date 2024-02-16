import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/screen/e_cormmerce/cart.dart';
import 'package:green_circle/screen/e_cormmerce/profile_screen.dart';
import 'package:green_circle/widgets/e_cormmerce/nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

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
    ProfileScreen(),
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
        height: 75,
        color: lightGray,
        shape: const CircularNotchedRectangle(),
        shadowColor: mediumGray,
        notchMargin: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            labelIcon(Icons.home_outlined,0,"Home"),
            Padding(
              padding: const EdgeInsets.only(left:0,right:40),
              child: labelIcon(Icons.support_agent,1,"Chat"),
            ),
            Padding(
              padding: const EdgeInsets.only(left:29,right:0),
              child: labelIcon(Icons.favorite_border_rounded,3,"Likes"),
            ),
            labelIcon(Icons.person,4,"Profile"),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }

  Widget labelIcon(IconData icon,int selectedTab,String label){
    return TextButton.icon(
      onPressed:(){
        setState(() {
          currentTab = selectedTab;
        });
      },
      style:ButtonStyle(
          iconColor:currentTab==selectedTab?const MaterialStatePropertyAll<Color>(Colors.white):const MaterialStatePropertyAll<Color>(mediumGray),
          backgroundColor:currentTab==selectedTab?const MaterialStatePropertyAll<Color>(green1):const MaterialStatePropertyAll<Color>(lightGray)
      ),
      icon: Icon(icon),
      label: Text(currentTab==selectedTab?label:"",
        style:GoogleFonts.almarai(
            color:currentTab==selectedTab?Colors.white:mediumGray
        ),
      ),
    );
  }
}
