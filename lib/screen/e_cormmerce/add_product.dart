import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/category.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/screen/e_cormmerce/main_screen.dart';
import 'package:green_circle/services/database.dart';
import 'dart:math';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey =GlobalKey<FormState>();
  List<String> imagesUrl = [];
  final storageRef = FirebaseStorage.instance.ref();
  List<String> imagesPath=[];
  String getRandom(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random r = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }

  String title='',price='',label='',remain='';
  String? description;
  final titleEditingController= TextEditingController();
  final priceEditingController= TextEditingController();
  final labelEditingController= TextEditingController();
  final remainEditingController= TextEditingController();
  final descriptionEditingController= TextEditingController();
  int productId = 0;

  @override
  Widget build(BuildContext context) {
    List<Product>? products = Provider.of<List<Product>?>(context);
    double widthR=MediaQuery.of(context).size.width;
    Category category=Category(title: title, image:"assets/images/logo.png",location:"Ha noi");
    if (products != null) {
      setState(() {
        productId = products.length;
      });
    }

    void tapImages(){
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
                title: Center(child: Text('Upload from:', style: title3)),
                backgroundColor: Colors.white,
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () {
                      uploadImagesFromGallery("$productId/${getRandom(10)}");
                    },
                    icon: const Icon(Icons.image),
                    label: Text("Gallery", style: snackBarFonts,),
                    style: const ButtonStyle(
                        iconColor: MaterialStatePropertyAll<Color>(Colors.white),
                        backgroundColor: MaterialStatePropertyAll<Color>(green1)
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      uploadImagesFromCamera("$productId/${getRandom(10)}");
                    },
                    icon: const Icon(Icons.camera),
                    label: Text("Camera", style: snackBarFonts,),
                    style: const ButtonStyle(
                        iconColor: MaterialStatePropertyAll<Color>(Colors.white),
                        backgroundColor: MaterialStatePropertyAll<Color>(green1)
                    ),),
                ]
            );
          }
      );
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40,horizontal:15),
          children: [
            Center(
              child:Text("Product Information",style:title2Black,)
            ),
            const SizedBox(
              height: 15,
            ),
            Text("Please choose to add at most 6 more product photos of the product to help users better understand it",style:body1Black,),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      tapImages();
                    },
                    child:addImages(imagesPath.isNotEmpty?imagesPath[0]:null,0)
                ),
                GestureDetector(
                    onTap: () {
                      tapImages();
                    },
                    child:addImages(imagesPath.length>1?imagesPath[1]:null,1)
                ),
                GestureDetector(
                    onTap: () {
                      tapImages();
                    },
                    child:addImages(imagesPath.length>2?imagesPath[2]:null,2)
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      tapImages();
                    },
                    child:addImages(imagesPath.length>3?imagesPath[3]:null,3)
                ),
                GestureDetector(
                    onTap: () {
                      tapImages();
                    },
                    child:addImages(imagesPath.length>4?imagesPath[4]:null,4)
                ),
                GestureDetector(
                    onTap: () {
                      tapImages();
                    },
                    child:addImages(imagesPath.length>5?imagesPath[5]:null,5)
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Product title:",style:body1Black,),
            inputTitleText(),
            const SizedBox(
              height: 10,
            ),
            Text("Product price:",style:body1Black,),
            inputPriceText(),
            const SizedBox(
              height: 10,
            ),
            Text("Number of remaining products:",style:body1Black,),
            inputRemainText(),
            const SizedBox(
              height: 10,
            ),
            Text("Product label:",style:body1Black,),
            inputLabelText(),
            const SizedBox(
              height: 10,
            ),
            Text("Entering more descriptions helps customers understand the product better:",style:body1Black,),
            inputDescriptionText(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal:60),
              child: Container(
                height: 50,
                width:widthR,
                decoration:BoxDecoration(
                    color: green1,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: TextButton(
                  onPressed:()async{
                    if(_formKey.currentState!.validate()){
                      await Database().updateProductData(
                          Product(
                              likedNumber: 0,
                              purchasesNumber: 0,
                              onSale: false,
                              title: title,
                              description: description??"",
                              image: imagesUrl,
                              price: double.parse(price),
                              category:category,
                              rate: 0,
                              label: label,
                              productId: productId.toString(),
                              remain:int.parse(remain)), productId.toString());
                      final snackBar = SnackBar(
                        backgroundColor: green1,
                        content: Text('Upload successfully', style: snackBarFonts),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      titleEditingController.clear();
                      labelEditingController.clear();
                      descriptionEditingController.clear();
                      priceEditingController.clear();
                      remainEditingController.clear();
                      setState(() {
                        imagesPath.removeRange(0,imagesPath.length);
                        imagesUrl.removeRange(0,imagesUrl.length);
                      });
                    }
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const MainScreen()));
                  },
                  child:Text(
                    "Save",
                    style: GoogleFonts.almarai(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addImages(String? imagePath,int index) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Stack(
          children:[
            SizedBox(
              height: 160,
              width: 90,
              child:imagePath!=null?Image(image: FileImage(File(imagePath))):const Icon(Icons.add,size:30,color: Colors.grey,)
          ),
            Positioned(
              top: -10,
              right: -10,
              child:imagePath!=null?IconButton(
                  onPressed:(){
                    setState(() {
                      imagesUrl.removeAt(index);
                      imagesPath.removeAt(index);
                    });
                  },
                  icon: const Icon(Icons.remove_circle_sharp,color:green1,)):const SizedBox(height:1,width:1,),
            ),
        ]
        ),
      ),
    );
  }
  Future<void> uploadImagesFromGallery(String imageUrl) async {
    final userRef = storageRef.child(imageUrl);
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? file = File(pickedFile.path);
      UploadTask uploadTask = userRef.putFile(file);
      final snackBar = SnackBar(
        backgroundColor: green1,
        content: Text('Upload successfully', style: snackBarFonts),
      );
      await uploadTask.whenComplete(() async {
        setState(() {
          imagesPath.add(file.path);
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        try {
          String imageUrl = await userRef.getDownloadURL();
          imagesUrl.add(imageUrl);
        } catch (e) {
          debugPrint("Error getting download URL: $e");
        }
      });
    }
    else{
      final snackBar = SnackBar(
        backgroundColor: red,
        content: Text('Please select a image from gallery', style: snackBarFonts),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> uploadImagesFromCamera(String imageUrl) async {
    final userRef = storageRef.child(imageUrl);
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File? file = File(pickedFile.path);
      UploadTask uploadTask = userRef.putFile(file);
      final snackBar = SnackBar(
        backgroundColor: green1,
        content: Text('Upload successfully', style: snackBarFonts),
      );
      await uploadTask.whenComplete(() async {
        setState(() {
          imagesPath.add(file.path);
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        try {
          String imageUrl = await userRef.getDownloadURL();
          imagesUrl.add(imageUrl);
        } catch (e) {
          debugPrint("Error getting download URL: $e");
        }
      });
    }
    else{
      final snackBar = SnackBar(
        backgroundColor: red,
        content: Text('Please select a image from camera', style: snackBarFonts),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  InputDecoration? inputDecoration(String label){
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius:borderRadius,
            borderSide:borderSideWhite
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius:borderRadius,
            borderSide:borderSideGreen
        ),
        fillColor: lightGray,
        filled: true,
        labelText:label,
        labelStyle:GoogleFonts.outfit(fontSize:15,color:Colors.black,fontWeight:FontWeight.w500)
    );
  }
  Widget inputTitleText(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10),
      child: TextFormField(
          validator: (val) {
            if(val==null||val.isEmpty){
              return 'Product title is necessary';
            }
            else
            {return null;}
          },
          controller: titleEditingController,
          onChanged: (text){
            setState(() {
              title=text;
            });
          },
          decoration:inputDecoration('Product title')
      ),
    );
  }
  Widget inputPriceText(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10),
      child: TextFormField(
          validator: (val) {
            if(val==null||val.isEmpty){
              return 'Product price is necessary';
            }
            else
            {return null;}
          },
          controller: priceEditingController,
          onChanged: (text){
            setState(() {
              price=text;
            });
          },
          decoration:inputDecoration('Product price')
      ),
    );
  }
  Widget inputLabelText(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10),
      child: TextFormField(
          validator: (val) {
            if(val==null||val.isEmpty){
              return 'Product label is necessary';
            }
            else
            {return null;}
          },
          controller: labelEditingController,
          onChanged: (text){
            setState(() {
              label=text;
            });
          },
          decoration:inputDecoration('Product label')
      ),
    );
  }
  Widget inputRemainText(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10),
      child: TextFormField(
          validator: (val) {
            if(val==null||val.isEmpty){
              return 'Number of remaining products is necessary';
            }
            else
            {return null;}
          },
          controller: remainEditingController,
          onChanged: (text){
            setState(() {
              remain=text;
            });
          },
          decoration:inputDecoration('Number of remaining products')
      ),
    );
  }
  Widget inputDescriptionText(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10),
      child: TextField(
          controller: descriptionEditingController,
          onChanged: (text){
            setState(() {
              description=text;
            });
          },
          decoration:inputDecoration('Description')
      ),
    );
  }
}
