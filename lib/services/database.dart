import 'package:flutter/material.dart';
import 'package:green_circle/models/user.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/models/cart_item.dart';
import 'package:green_circle/models/category.dart';
import 'package:green_circle/constants.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class Database{
  String? uid;
  Database({this.uid});
  final CollectionReference userCollection=FirebaseFirestore.instance.collection('user');
  final CollectionReference productionCollection=FirebaseFirestore.instance.collection('production');
  final CollectionReference cartItemsCollection=FirebaseFirestore.instance.collection('cart_items');
  final CollectionReference categoryCollection=FirebaseFirestore.instance.collection('category');
  //update and get stream user information data
  Future updateUserData(UserInformation userInformation) async{
    try{
      return await userCollection.doc(uid).set({
        'name': userInformation.name,
        'voucherId': userInformation.voucherId,
        'imageUrl': userInformation.imageUrl,
        'cartItems': userInformation.cartItems?.map((item) => item.toJson()).toList(),
        'boughtProduct': userInformation.boughtProduct?.map((product) => product.toJson()).toList(),
        'likedProduct': userInformation.likedProduct?.map((product) => product.toJson()).toList(),
        'soldProduct': userInformation.soldProduct?.map((product) => product.toJson()).toList(),
      });
    }
    catch(e){
      debugPrint("Error updating user information: $e");
    }
  }

  List<UserInformation> _authDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return UserInformation(
        name: doc.data().toString().contains('name') ? doc.get('name') : "",
        voucherId: data.containsKey('voucherId') ? List.from(data['voucherId']) :[''],
        imageUrl: doc.data().toString().contains('imageUrl')?doc.get('imageUrl'):null, //nullable
        cartItems: (data['cartItems'] as List<dynamic>?)
            ?.map((item) => CartItem.fromJson(item))
            .toList(),
        boughtProduct: (data['boughtProduct'] as List<dynamic>?)
            ?.map((product) => Product.fromJson(product))
            .toList(),
        likedProduct: (data['likedProduct'] as List<dynamic>?)
            ?.map((product) => Product.fromJson(product))
            .toList(),
        soldProduct: (data['soldProduct'] as List<dynamic>?)
            ?.map((product) => Product.fromJson(product))
            .toList(),
      );
    }).toList();
  }

  Stream<List<UserInformation>?> get authData{
    return userCollection.snapshots().map((_authDataFromSnapshot));
  }


  //update and get product data
  Future updateProductData(Product product,String productId) async{
    try{
      return await productionCollection.doc(productId).set({
        "category":product.category,
        "colors":product.colors,
        "description":product.description,
        "image":product.image,
        "label":product.label,
        "likedNumber":product.likedNumber,
        "onSale":product.onSale,
        "price":product.price,
        "purchasesNumber":product.purchasesNumber,
        "productId":productId,
        "rate":product.rate,
        "title":product.title
      });
    }
    catch(e){
      debugPrint("Error updating production information: $e");
    }
  }

  List<Product> _productDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Product(
        likedNumber: data['likedNumber'] ?? 0,
        purchasesNumber: data['purchasesNumber'] ?? 0,
        onSale: data['onSale'] ?? false,
        title: data['title'] ?? "",
        description: data['description'] ?? "",
        image: List<String>.from(data['image'] ?? []),
        price: data['price'] ?? 0.0,
        colors: (data['colors'] as List<dynamic>?)
            ?.map((colorHex) => colorHex.toString())
            .toList() ?? [],
        category: Category.fromJson(data['category'] ?? {}),
        rate: data['rate'] ?? 0.0,
        label: data['label'] ?? "",
        productId: doc.id,
      );
    }).toList();
  }

  Stream<List<Product>> get productData {
    return productionCollection.snapshots().map((_productDataFromSnapshot));
  }

  //upload and get image url
  final storageRef = FirebaseStorage.instance.ref();
  Future<void> uploadImageFromGallery(BuildContext context,String imageUrl)async{
    final userRef= storageRef.child(imageUrl);
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      File? file = File(pickedFile.path);
      UploadTask uploadTask= userRef.putFile(file);
      final snackBar = SnackBar(
        backgroundColor:green1,
        content:Text('Upload successfully',style:snackBarFonts),
      );
      await uploadTask.whenComplete(() async {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        try {
          String imageUrl = await userRef.getDownloadURL();
          // Update the imageUrl field in Firestore
          await userCollection.doc(uid).update({'imageUrl': imageUrl});
        } catch (e) {
          debugPrint("Error getting download URL: $e");
        }
      });
    }
    else{
      final snackBar = SnackBar(
        backgroundColor:red,
        content:Text('Please select an image from gallery',style:snackBarFonts),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> uploadImageFromCamera(BuildContext context,String imageUrl)async{
    final userRef= storageRef.child(imageUrl);
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if(pickedFile != null){
      File? file = File(pickedFile.path);
      UploadTask uploadTask= userRef.putFile(file);
      final snackBar = SnackBar(
        backgroundColor:green1,
        content:Text('Upload successfully',style:snackBarFonts),
      );
      await uploadTask.whenComplete(() async {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        try {
          String imageUrl = await userRef.getDownloadURL();
          // Update the imageUrl field in Firestore
          await userCollection.doc(uid).update({'imageUrl': imageUrl});
        } catch (e) {
          debugPrint("Error getting download URL: $e");
        }
      });
    }
    else{
      final snackBar = SnackBar(
        backgroundColor:red,
        content:Text('Please select an image from camera',style:snackBarFonts),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> uploadImagesFromGallery(BuildContext context,String imageUrl,String id)async{
    final userRef= storageRef.child(imageUrl);
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      File? file = File(pickedFile.path);
      UploadTask uploadTask= userRef.putFile(file);
      final snackBar = SnackBar(
        backgroundColor:green1,
        content:Text('Upload successfully',style:snackBarFonts),
      );
      await uploadTask.whenComplete(() async {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        try {
          String imageUrl = await userRef.getDownloadURL();
          // Update the imageUrl field in Firestore
          await userCollection.doc(id).update({'imageUrl': imageUrl});
        } catch (e) {
          debugPrint("Error getting download URL: $e");
        }
      });
    }
    else{
      final snackBar = SnackBar(
        backgroundColor:red,
        content:Text('Please select an image from gallery',style:snackBarFonts),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> uploadImagesFromCamera(BuildContext context,String imageUrl)async{
    final userRef= storageRef.child(imageUrl);
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if(pickedFile != null){
      File? file = File(pickedFile.path);
      UploadTask uploadTask= userRef.putFile(file);
      final snackBar = SnackBar(
        backgroundColor:green1,
        content:Text('Upload successfully',style:snackBarFonts),
      );
      await uploadTask.whenComplete(() async {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        try {
          String imageUrl = await userRef.getDownloadURL();
          // Update the imageUrl field in Firestore
          await userCollection.doc(uid).update({'imageUrl': imageUrl});
        } catch (e) {
          debugPrint("Error getting download URL: $e");
        }
      });
    }
    else{
      final snackBar = SnackBar(
        backgroundColor:red,
        content:Text('Please select an image from camera',style:snackBarFonts),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}