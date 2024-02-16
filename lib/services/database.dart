import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Database{
  String? uid;
  Database({this.uid});
  final CollectionReference userCollection=FirebaseFirestore.instance.collection('user');
  Future updateData(String? fullName,String? assets) async{
    return await userCollection.doc(uid).set({
      "name":fullName,
      "assets":assets,
      "uid":uid
    });
  }

  final storageRef = FirebaseStorage.instance.ref();
  Future<void> uploadImage(BuildContext context)async{
    final userRef= storageRef.child("$uid/test.png");
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      File? file = File(pickedFile.path);
      UploadTask uploadTask= userRef.putFile(file);
      final snackBar = SnackBar(
        backgroundColor:green1,
        content:Text('Upload successfully',style:snackBarFonts),
      );
      uploadTask.whenComplete(() =>ScaffoldMessenger.of(context).showSnackBar(snackBar));
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