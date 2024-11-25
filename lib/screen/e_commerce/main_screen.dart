import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/screen/e_commerce/add_product.dart';
import 'package:green_circle/screen/e_commerce/chat_screen.dart';
import 'package:green_circle/screen/mapbox/map.dart';
import 'package:green_circle/screen/e_commerce/profile_screen.dart';
import 'package:green_circle/screen/scan_screen.dart';
import 'package:green_circle/widgets/e_commerce/nav_bar.dart';
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
    ChatScreen(),
    ScanScreen(),
    FullMap(),
    MeScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            labelIcon(Icons.message_outlined ,1,"Chat"),
            Padding(
              padding: currentTab==2?const EdgeInsets.only(left:5,right:4):const EdgeInsets.only(left:2),
              child: labelIcon(Icons.document_scanner_outlined,2,"Scan")
            ),
            Padding(
              padding: currentTab==3?const EdgeInsets.only(left:3,right: 5):const EdgeInsets.only(left:2),
              child: labelIcon(Icons.map,3,"Map")
            ),
            Padding(
              padding:const EdgeInsets.only(left:1),
              child: labelIcon(Icons.person,4,"Profile"),
            ),
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
          iconColor:currentTab==selectedTab?const WidgetStatePropertyAll<Color>(Colors.white):const WidgetStatePropertyAll<Color>(mediumGray),
          backgroundColor:currentTab==selectedTab?const WidgetStatePropertyAll<Color>(green1):const WidgetStatePropertyAll<Color>(lightGray)
      ),
      icon: Icon(icon),
      label: Text(currentTab==selectedTab?label:"",
        style:GoogleFonts.almarai(
            color:currentTab==selectedTab?Colors.white:mediumGray
        ),
      ),
    );
  }

  Widget instruction(String text,double width,double sWidth){
    return Container(
      height: 320,
      width: width,
      padding: const EdgeInsets.all(10),
      child: Stack(
        children:[
          Image.asset('assets/images/dump.png',height: 200,width: 200,),
          Positioned(
            top:0,
            right:0,
            child: Container(
              width: sWidth,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
                border: Border.all(color: Colors.black87),
              ),
              child: Center(
                child: Text(text, style: body1Black, textAlign: TextAlign.center,),
              ),
            ),
          )
        ]
      ),
    );
  }
}
