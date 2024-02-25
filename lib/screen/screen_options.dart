import 'package:flutter/material.dart';
import 'package:green_circle/screen/e_commerce/main_screen.dart';
import 'package:green_circle/screen/mapbox/map.dart';
import 'package:green_circle/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenOptions extends StatelessWidget {
  const ScreenOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SizedBox(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
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
                icon:const Icon(Icons.map)
            ),
            IconButton(
                onPressed:(){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const MainScreen()));
                },
                icon:const Icon(Icons.home)
            )
          ],
        ),
      ),
    );
  }
}
