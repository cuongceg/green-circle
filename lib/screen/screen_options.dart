import 'package:flutter/material.dart';
import 'package:green_circle/screen/e_cormmerce/main_screen.dart';
import 'package:green_circle/screen/mapbox/map.dart';
import 'package:green_circle/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenOptions extends StatelessWidget {
  const ScreenOptions({super.key});
  @override
  Widget build(BuildContext context) {
    final double heightR=MediaQuery.of(context).size.height;
    TextStyle textStyle=GoogleFonts.almarai(fontSize:18,color:Colors.black,fontWeight:FontWeight.w700);
    return Scaffold(
      body:SizedBox(
        child:Center(
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
                      onPressed:(){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const MainScreen()));
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
      ),
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
}
