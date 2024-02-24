import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/user.dart';
import 'package:green_circle/services/auth_services.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imageUrl;
  String getRandom(int length){
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random r = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }
  int productId= 1;
  // late ClassificationResult _classificationResult;
  File? _image;
  Future<void> classifyImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      // List<int> imageBytes = await pickedFile.readAsBytes();
      // String imageData = base64Encode(imageBytes);
      setState(() {
        _image=File(pickedFile.path);
      });
    }
    FormData formData=FormData.fromMap({
      'image':await MultipartFile.fromFile(_image!.path,filename: 'upload.jpg',),
    });
    try{
      Dio dio =Dio();
      Response response=await dio.post("https://detect.roboflow.com/green002/1?api_key=KyfqRDG7dsGUbfwoT65T",data:formData);
      debugPrint("${response.statusCode}");
    }catch(e){
      debugPrint("$e");
    }
  }
  @override
  Widget build(BuildContext context) {
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
                  classifyImage();
                },
                icon: const Icon(Icons.image)),
          ],
        )
      ),
    );
  }
}
