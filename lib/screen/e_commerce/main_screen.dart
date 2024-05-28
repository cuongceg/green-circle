import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/screen/mapbox/map.dart';
import 'package:green_circle/screen/e_commerce/profile_screen.dart';
import 'package:green_circle/screen/scan_screen.dart';
import 'package:green_circle/screen/user%20shop/create_shop.dart';
import 'package:green_circle/widgets/e_commerce/nav_bar.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  late TutorialCoachMark tutorialCoachMark;
  GlobalKey homeButton=GlobalKey();
  GlobalKey scanButton=GlobalKey();
  GlobalKey gameButton=GlobalKey();
  GlobalKey mapButton=GlobalKey();
  GlobalKey profileButton=GlobalKey();
  GlobalKey welcome=GlobalKey();
  List screens = const [
    NavBar(),
    ScanScreen(),
    ShopInfoScreen(),
    FullMap(),
    MeScreen(),
  ];
  @override
  void initState() {
    super.initState();
    createUserGuide();
    showUserGuide();
  }
  @override
  void dispose() {
    tutorialCoachMark.finish();
    super.dispose();
  }

  void showUserGuide(){
    tutorialCoachMark.show(context: context);
  }
  void createUserGuide(){
    tutorialCoachMark=TutorialCoachMark(
      targets: _createdTargets(),
      colorShadow: greenGray,
      textSkip: "SKIP",
      textStyleSkip: snackBarFonts,
      paddingFocus: 5,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
    );
  }

  List<TargetFocus> _createdTargets(){
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "homeButton",
        keyTarget: homeButton,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(bottom: -10,left:-50,right:00),
            child: instruction("Đây là màn hình chính của ứng dụng, nơi mua sắm dành riêng cho bạn",450,250),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "scanButton",
        keyTarget: scanButton,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        radius: 5,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(bottom: -50,left:-50,right:0),
            child: instruction("Hãy thử tính năng quét sản phẩm có thể tái chế không ở đây ",450,250),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "gameButton",
        keyTarget: gameButton,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        radius: 5,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(bottom: -110,left:-50,right:0),
            child: instruction("Trò chơi phân loại rác thú vị nằm ở đây",450,250),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "mapButton",
        keyTarget: mapButton,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        radius: 5,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(bottom: -135,left:-50,right:0),
            child: instruction("Theo dõi đơn hàng dễ dàng và tìm các địa điểm thu gom rác gần mình",450,250),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "profileButton",
        keyTarget: profileButton,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        radius: 5,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(bottom: -135,left:-50,right:0),
            child: instruction("Đây là hồ sơ của bạn",450,250),
          ),
        ],
      ),
    );
    return targets;
  }

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
            labelIcon(Icons.home_outlined,0,"Home",homeButton),
            labelIcon(Icons.document_scanner_outlined ,1,"Scan",scanButton),
            Padding(
              padding: currentTab==2?const EdgeInsets.only(left:5,right:3.9):const EdgeInsets.only(left:2),
              child: labelIcon(Icons.videogame_asset_outlined,2,"Game",gameButton),
            ),
            Padding(
              padding: currentTab==3?const EdgeInsets.only(left:3,right: 5):const EdgeInsets.only(left:2),
              child: labelIcon(Icons.map,3,"Map",mapButton),
            ),
            Padding(
              padding:const EdgeInsets.only(left:1),
              child: labelIcon(Icons.person,4,"Profile",profileButton),
            ),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }

  Widget labelIcon(IconData icon,int selectedTab,String label,Key? key){
    return TextButton.icon(
      key: key,
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
