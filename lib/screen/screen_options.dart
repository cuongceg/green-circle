import 'package:flutter/material.dart';
import 'package:green_circle/screen/e_commerce/main_screen.dart';
import 'package:green_circle/screen/mapbox/map.dart';
import 'package:green_circle/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenOptions extends StatefulWidget {
  const ScreenOptions({super.key});

  @override
  State<ScreenOptions> createState() => _ScreenOptionsState();
}

class _ScreenOptionsState extends State<ScreenOptions> {
  int currentTab = 0;
  List<Widget>screens = const [
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    final double heightR=MediaQuery.of(context).size.height;
    TextStyle textStyle=GoogleFonts.almarai(fontSize:18,color:Colors.black,fontWeight:FontWeight.w700);
    return Scaffold(
        body:SizedBox(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height:100,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25),
                child: Text("Hello,Phuong",style:heading3,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10),
                child:TextButton.icon(
                    onPressed:(){},
                    icon:const Icon(Icons.location_on,color: green1,),
                    label:Text("Hoang Mai,Ha Noi",style:body1Green,),
                )
              ),
              const SizedBox(height:50,),
              Center(
                child: CarouselSlider(
                  items: [
                    item("assets/images/location_image.png",
                      TextButton(
                        onPressed:()async{
                          var status = await Permission.locationWhenInUse.request();
                          if(status==PermissionStatus.granted){
                            Duration duration=const Duration(milliseconds:500);
                            Future.delayed(duration,(){
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const FullMap()));
                            });
                          }
                          else{
                            final snackBar = SnackBar(
                              backgroundColor:red,
                              content: Text('No location permission',style:snackBarFonts,),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        child: Text("Visit us in map",style:textStyle,),
                      ),
                    ),
                    item("assets/images/ecommerce_image.png",
                      TextButton(
                          onPressed:()async{
                            var status = await Permission.manageExternalStorage.request();
                            if (status == PermissionStatus.granted) {
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const MainScreen()));
                            }
                            else{
                              final snackBar = SnackBar(
                                backgroundColor:red,
                                content: Text('No storage permission',style:snackBarFonts,),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: Text("Ecommerce platforms",style: textStyle,)
                      ),
                    ),
                    item("assets/images/game_image.png",
                      TextButton(
                          onPressed:(){},
                          child: Text("Game platforms",style: textStyle,)
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                      height: heightR/2,
                      aspectRatio: 4/3,
                      enlargeCenterPage: true,
                      viewportFraction:0.7,
                      autoPlay:true,
                      autoPlayInterval: const Duration(seconds:6)
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:BottomAppBar(
          elevation: 0,
          height: 75,
          color: lightGray,
          shadowColor: mediumGray,
          notchMargin: 5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:12),
                child: labelIcon(Icons.home_outlined,0,"Home"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:12),
                child: labelIcon(Icons.handshake,1,"Convert"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10),
                child: labelIcon(Icons.notifications,3,"Notifications"),
              ),
              labelIcon(Icons.person,4,"Profile"),
            ],
          ),
        )
    );
  }
  Widget item(String assetImage,Widget child){
    return Container(
      decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(60),
          border:Border.all(
              width:2,
              color:lightGray
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(2, 4),)
          ],
          image: DecorationImage(image:AssetImage(assetImage),fit:BoxFit.fill)
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 25,
            child:Container(
              height: 60,
              width: 220,
              decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(50),
                  border:Border.all(
                      width:2,
                      color:Colors.black
                  ),
                  color: Colors.white
              ),
              child: Center(
                child: child,
              ),
            ),
          )
        ],
      ),
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

