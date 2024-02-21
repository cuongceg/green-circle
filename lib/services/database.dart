import 'package:flutter/material.dart';
import 'package:green_circle/models/user.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/models/cart_item.dart';
import 'package:green_circle/constants.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
//TODO(cuongceg): add new stream to get data
/*
Example:
List<UserInformation>_authDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return UserInformation(
        username:doc.data().toString().contains('username')?doc.get('username'):" ",
        fullname:doc.data().toString().contains('fullname')?doc.get('fullname'):" ",
        asset:doc.data().toString().contains('assets')?doc.get('assets'):" ",
        uid:doc.data().toString().contains('uid')?doc.get('uid'):" ",
    );//UserInformation is a class in model
    }).toList();
  }

  Stream<List<UserInformation>> get authData{
    return userCollection.snapshots().map((_authDataFromSnapshot));
  }
 */
class Database{
  String? uid;
  Database({this.uid});
  final CollectionReference userCollection=FirebaseFirestore.instance.collection('user');
  final CollectionReference productionCollection=FirebaseFirestore.instance.collection('production');
  final CollectionReference cartItemsCollection=FirebaseFirestore.instance.collection('cart_item');
  final CollectionReference categoryCollection=FirebaseFirestore.instance.collection('category');
  //update and get stream user information data
  Future updateData(UserInformation userInformation) async{
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
        name: data.containsKey('name') ? data['name'] : "",
        voucherId: data.containsKey('voucherId') ? data['voucherId'] : "",
        imageUrl: data['imageUrl'], // có thể null
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

  //upload and get image url
  final storageRef = FirebaseStorage.instance.ref();
  Future<void> uploadImage(BuildContext context)async{
    final userRef= storageRef.child("$uid/test1.png");
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
          print("Error getting download URL: $e");
        }
      });
    }
    else{
      final snackBar = SnackBar(
        backgroundColor:red,
        content:Text('Please select an image',style:snackBarFonts),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}