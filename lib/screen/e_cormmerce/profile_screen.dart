import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/user.dart';
import 'package:green_circle/services/auth_services.dart';
import 'package:green_circle/services/database.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imageUrl;
  DateFormat dateFormat=DateFormat('yyyyMMddhhmmss');
  String getRandom(int length){
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random r = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }
  int productId= 1;
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<MyUser?>(context);
    final userInformation=Provider.of<List<UserInformation>?>(context);
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    if(userInformation!=null){
       imageUrl=userInformation[0].imageUrl;
       // debugPrint(imageUrl??"");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body:SizedBox(
        height:height,
        width: width,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage:imageUrl!=null?NetworkImage(imageUrl!):const AssetImage('assets/images/logo.png') as ImageProvider,
              radius: 40,
            ),
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
                  Database(uid:user!.uid).uploadImageFromGallery(context,"$productId/${getRandom(10)}");
                },
                icon: const Icon(Icons.image)),
            IconButton(
                onPressed:(){
                  Database(uid:user!.uid).uploadImageFromCamera(context,"$productId/${getRandom(10)}");
                },
                icon: const Icon(Icons.camera)),
            IconButton(
                onPressed:(){
                  setState(() {
                    productId++;
                  });
                },
                icon: const Icon(Icons.save_alt)),
            // IconButton(
            //     onPressed:(){
            //       Database(uid:user!.uid).up;
            //     },
            //     icon: const Icon(Icons.camera)),
          ],
        )
      ),
    );
  }
}
