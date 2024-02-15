import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/services/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body:SizedBox(
        height:200,
        width: width,
        child:Center(
          child: TextButton.icon(
            style: const ButtonStyle(
              backgroundColor:MaterialStatePropertyAll<Color>(green1),
              fixedSize: MaterialStatePropertyAll<Size>(Size(285,55))
            ),
            icon:const Icon(Icons.logout,color:Colors.white,size:30,),
            label:Text("Sign out",style: GoogleFonts.almarai(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),),
            onPressed:(){
              AuthService().signOut();
            },
          ),
        ),
      ),
    );
  }
}
