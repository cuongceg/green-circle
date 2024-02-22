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
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:dio/dio.dart';
import 'dart:math';

// TODO: add new stream to get data.
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
  Future updateData(String? fullName,String? assets) async{
    return await userCollection.doc(uid).set({
      "name":fullName,
      "assets":assets,
      "uid":uid
    });
  }

  // database upload image
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


  //database direction to recycling locations
  Future getShortestPath(MapboxMapController mapController,List<Line> existingLines)async{
    String url1 ="https://api.mapbox.com/directions/v5/mapbox/driving/105.844920,21.005000;105.844655,20.980339?geometries=geojson&access_token=pk.eyJ1IjoidGh1Y2t1YmluIiwiYSI6ImNsbTYxYzJ1azB2MjQzcHA0NGR0YnIxMTUifQ.88hO1oKIFSZsljzkR2vP8w";
    String url2 ="https://api.mapbox.com/directions/v5/mapbox/driving/105.853674,20.981340;105.844655,20.980339?geometries=geojson&access_token=pk.eyJ1IjoidGh1Y2t1YmluIiwiYSI6ImNsbTYxYzJ1azB2MjQzcHA0NGR0YnIxMTUifQ.88hO1oKIFSZsljzkR2vP8w";
    String url3 ="https://api.mapbox.com/directions/v5/mapbox/driving/105.831959,20.963949;105.844655,20.980339?geometries=geojson&access_token=pk.eyJ1IjoidGh1Y2t1YmluIiwiYSI6ImNsbTYxYzJ1azB2MjQzcHA0NGR0YnIxMTUifQ.88hO1oKIFSZsljzkR2vP8w";
    try{
      Dio().options.contentType=Headers.jsonContentType;
      Response<Map<String,dynamic>> responseData1= await Dio().get<Map<String,dynamic>>(url1);
      Response<Map<String,dynamic>> responseData2= await Dio().get<Map<String,dynamic>>(url2);
      Response<Map<String,dynamic>> responseData3= await Dio().get<Map<String,dynamic>>(url3);
      debugPrint('${responseData1.statusCode},${responseData2.statusCode},${responseData3.statusCode}');
      if(responseData1.statusCode==200&&responseData2.statusCode==200&&responseData3.statusCode==200){
        Map<String,dynamic>? data1=responseData1.data;
        Map<String,dynamic>? data2=responseData2.data;
        Map<String,dynamic>? data3=responseData3.data;
        if(data1!=null&&data2!=null&&data3!=null){
          List<dynamic> routes1=data1['routes'];
          List<dynamic> routes2=data2['routes'];
          List<dynamic> routes3=data3['routes'];
          double distance1=routes1[0]['distance'].toDouble();
          double distance2=routes2[0]['distance'].toDouble();
          double distance3=routes3[0]['distance'].toDouble();
          double shortestDistance=min(min(distance1,distance2),distance3);
          List<dynamic> shortestRoutes;
          if(shortestDistance==distance1){
            shortestRoutes=List.from(routes1);
            debugPrint('$distance1,$distance2,$distance3');
          }
          else if(shortestDistance==distance2){
            shortestRoutes=List.from(routes2);
          }
          else{
            shortestRoutes=List.from(routes3);
          }
          List<LatLng> coordinates = shortestRoutes.expand((route) {
            List<dynamic> geometryCoordinates = route['geometry']['coordinates'];
            return geometryCoordinates.map((coordinate) => LatLng(coordinate[1], coordinate[0])); // Reversed for LatLng format
          }).toList();
          for(Line line in existingLines){
            mapController.removeLine(line);
          }
          existingLines.clear();
          Line newLine = await mapController.addLine(
              LineOptions(
                  geometry: coordinates,
                  lineColor: "#5CAF56",
                  lineWidth:4.0,
                  lineJoin:'round'
              )
          );
          existingLines.add(newLine);
        }
      }
      return responseData1.data;
    }catch(e){
      debugPrint("Error fetching shortest path: $e");
      return null;
    }
  }
  Future<double> getLocation1Path(MapboxMapController mapController,List<Line> existingLines)async{
    String url ="https://api.mapbox.com/directions/v5/mapbox/driving/105.844920,21.005000;105.844655,20.980339?geometries=geojson&access_token=pk.eyJ1IjoidGh1Y2t1YmluIiwiYSI6ImNsbTYxYzJ1azB2MjQzcHA0NGR0YnIxMTUifQ.88hO1oKIFSZsljzkR2vP8w";
  try{
    Dio().options.contentType=Headers.jsonContentType;
    Response<Map<String,dynamic>> responseData= await Dio().get<Map<String,dynamic>>(url);
    debugPrint('${responseData.statusCode}');
    if(responseData.statusCode==200){
      Map<String,dynamic>? data=responseData.data;
      if(data!=null){
        List<dynamic> routes=data['routes'];
        List<LatLng> coordinates = routes.expand((route) {
          List<dynamic> geometryCoordinates = route['geometry']['coordinates'];
          return geometryCoordinates.map((coordinate) => LatLng(coordinate[1], coordinate[0])); // Reversed for LatLng format
        }).toList();
        for(Line line in existingLines){
          mapController.removeLine(line);
        }
        existingLines.clear();
        Line newLine = await mapController.addLine(
            LineOptions(
                geometry: coordinates,
                lineColor: "#5CAF56",
                lineWidth:4.0,
                lineJoin:'round'
            )
        );
        existingLines.add(newLine);
        return routes[0]['distance'].toDouble();
      }
    }
    return 0;
  }catch(e){
    debugPrint("Error fetching shortest path: $e");
    return 0;
  }
  }
  Future getLocation2Path(MapboxMapController mapController,List<Line> existingLines)async{
    String url ="https://api.mapbox.com/directions/v5/mapbox/driving/105.853674,20.981340;105.844655,20.980339?geometries=geojson&access_token=pk.eyJ1IjoidGh1Y2t1YmluIiwiYSI6ImNsbTYxYzJ1azB2MjQzcHA0NGR0YnIxMTUifQ.88hO1oKIFSZsljzkR2vP8w";
    try{
      Dio().options.contentType=Headers.jsonContentType;
      Response<Map<String,dynamic>> responseData= await Dio().get<Map<String,dynamic>>(url);
      debugPrint('${responseData.statusCode}');
      if(responseData.statusCode==200){
        Map<String,dynamic>? data=responseData.data;
        if(data!=null){
          List<dynamic> routes=data['routes'];
          List<LatLng> coordinates = routes.expand((route) {
            List<dynamic> geometryCoordinates = route['geometry']['coordinates'];
            return geometryCoordinates.map((coordinate) => LatLng(coordinate[1], coordinate[0])); // Reversed for LatLng format
          }).toList();
          for(Line line in existingLines){
            mapController.removeLine(line);
          }
          existingLines.clear();
          Line newLine = await mapController.addLine(
              LineOptions(
                  geometry: coordinates,
                  lineColor: "#5CAF56",
                  lineWidth:4.0,
                  lineJoin:'round'
              )
          );
          existingLines.add(newLine);
        }
      }
    }catch(e){
      debugPrint("Error fetching shortest path: $e");
      return null;
    }
  }
  Future getLocation3Path(MapboxMapController mapController,List<Line>existingLines)async{
    String url ="https://api.mapbox.com/directions/v5/mapbox/driving/105.831959,20.963949;105.844655,20.980339?geometries=geojson&access_token=pk.eyJ1IjoidGh1Y2t1YmluIiwiYSI6ImNsbTYxYzJ1azB2MjQzcHA0NGR0YnIxMTUifQ.88hO1oKIFSZsljzkR2vP8w";
    try{
      Dio().options.contentType=Headers.jsonContentType;
      Response<Map<String,dynamic>> responseData= await Dio().get<Map<String,dynamic>>(url);
      debugPrint('${responseData.statusCode}');
      if(responseData.statusCode==200){
        Map<String,dynamic>? data=responseData.data;
        if(data!=null){
          List<dynamic> routes=data['routes'];
          List<LatLng> coordinates = routes.expand((route) {
            List<dynamic> geometryCoordinates = route['geometry']['coordinates'];
            return geometryCoordinates.map((coordinate) => LatLng(coordinate[1], coordinate[0])); // Reversed for LatLng format
          }).toList();
          for(Line line in existingLines){
            mapController.removeLine(line);
          }
          existingLines.clear();
          Line newLine = await mapController.addLine(
              LineOptions(
                  geometry: coordinates,
                  lineColor: "#5CAF56",
                  lineWidth:4.0,
                  lineJoin:'round'
              )
          );
          existingLines.add(newLine);
        }
      }
    }catch(e){
      debugPrint("Error fetching shortest path: $e");
      return null;
    }
  }
}

