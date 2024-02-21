import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/user.dart';
import 'package:green_circle/services/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_circle/services/database.dart';
import 'package:provider/provider.dart';


// TODO: update UI
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<MyUser?>(context);
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body:SizedBox(
        height:height,
        width: width,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
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
            // button upload image to Firebase Storage
            IconButton(
                onPressed:(){
                  Database(uid:user!.uid).uploadImage(context);
                },
                icon: const Icon(Icons.upload)),
            IconButton(
                onPressed:(){},
                icon:const Icon(Icons.get_app)
            ),
          ],
        )
      ),
    );
  }
}
