import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_circle/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? _selectedImage;
  bool hasResult=false,onPressed=false;
  List<String>result=["loại 1","loại 1","loại 3","loại 2","loại 3"];
  List<String>composition=['Nhựa','Kim loại',"Đồ điện tử","Thức ăn","Pin"];
  List<String>suggestion=[
    'Bạn có thể cho sản phẩm vào thùng rác tái chế.',
    'Bạn có thể cho sản phẩm vào thùng rác tái chế.',
    'Bạn có thể cho sản phẩm vào thùng rác nguy hại.',
    'Bạn có thể cho sản phẩm vào thùng rác hữu cơ.',
    'Bạn có thể cho sản phẩm vào thùng rác nguy hại.'
  ];
  int index=-1;
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      body:Column(
        mainAxisAlignment:MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          Center(
            child: Container(
              height: 200,
              width: width-180,
              decoration:BoxDecoration(
                border: Border.all(),
              ),
              child:_selectedImage!=null?Image(image: FileImage(File(_selectedImage!.path))):const Icon(Icons.add,size:30,color: Colors.grey,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10,top: 20,bottom:20),
            child: Row(
              children:[
                Text("Upload from",style:title3Black,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10),
                  child: TextButton.icon(
                    onPressed:(){
                      _pickImageFromCamera();
                      setState(() {
                        onPressed=false;
                        hasResult=false;
                      });
                    },
                    style:const ButtonStyle(
                        iconColor:MaterialStatePropertyAll<Color>(Colors.white),
                        backgroundColor:MaterialStatePropertyAll<Color>(green1)
                    ),
                    icon: const Icon(Icons.camera),
                    label: Text("Camera",style:snackBarFonts,),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10),
                  child: TextButton.icon(
                    onPressed:(){
                      _pickImageFromGallery();
                      setState(() {
                        onPressed=false;
                        hasResult=false;
                      });
                    },
                    style:const ButtonStyle(
                        iconColor:MaterialStatePropertyAll<Color>(Colors.white),
                        backgroundColor:MaterialStatePropertyAll<Color>(green1)
                    ),
                    icon: const Icon(Icons.image),
                    label: Text("Thư viện",style:snackBarFonts,),
                  ),
                ),
              ],
            ),
          ),
          Center(
              child:Container(
                height:40,
                width: 285,
                decoration:BoxDecoration(
                  color: green1,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: TextButton(
                      onPressed:(){
                        setState(() {
                          onPressed=true;
                          if(index<4){
                            index++;
                          }
                        });
                        Timer(const Duration(seconds:2), () {
                          setState(() {
                            hasResult = true;
                          });
                        });
                      },
                      child: Text("Check ",style:GoogleFonts.almarai(fontSize:18,color:Colors.white,fontWeight: FontWeight.w700),)
                  ),
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:10,horizontal:10),
            child: Text("Kết quả :",style:title3Black,),
          ),
          onPressed?hasResult?
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:10,horizontal:10),
                  child:Text("- Sản phẩm ${result[index]}",style: label,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10,left:10,bottom:5),
                  child: Text("- Chất liệu sản phẩm : ${composition[index]}",style: label,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10,left:10,bottom:5),
                  child: Text("- ${suggestion[index]}",style: label,),
                ),
              ]
          ):const Center(
            child: CircularProgressIndicator(
              color: green1,
              strokeWidth: 4.0,
            ),
          ):const SizedBox(),
        ],
      ),
    );
  }
  Future _pickImageFromGallery()async{
    final returnedImage= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(returnedImage == null)return;
    setState(() {
      _selectedImage=File(returnedImage.path);
    });
  }
  Future _pickImageFromCamera()async{
    var returnedImage= await ImagePicker().pickImage(source: ImageSource.camera);
    if(returnedImage == null)return;
    setState(() {
      _selectedImage=File(returnedImage.path);
    });
  }
}