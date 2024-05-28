import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_circle/screen/e_commerce/wrapper.dart';
import 'package:animate_do/animate_do.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1900), () {
      // Navigate to the next screen after the delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Wrapper()),
      );
    });
    double heightR=MediaQuery.of(context).size.height;
    double widthR=MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        child:Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
              width: widthR,
              height: heightR,
              child: Stack(
                children:[
                  Positioned(
                    top: 120,
                    left: 80,
                    child: FadeInDownBig(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 1500),
                      child: SizedBox(
                        width: widthR /1.6,
                        height: heightR /1.6,
                        child: Center(
                          child:Image.asset("assets/images/logo.png",),),
                      ),
                    ),
                  ),
                ],)
          ),
        )
    );
  }
}
