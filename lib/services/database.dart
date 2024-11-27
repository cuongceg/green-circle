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

class Database{
  String? uid;
  Database({this.uid});
  final CollectionReference userCollection=FirebaseFirestore.instance.collection('user');
  final CollectionReference productionCollection=FirebaseFirestore.instance.collection('product');
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
        "category":product.category.toMap(),
        "description":product.description,
        "image":product.image,
        "label":product.label,
        "likedNumber":product.likedNumber,
        "onSale":product.onSale,
        "price":product.price,
        "purchasesNumber":product.purchasesNumber,
        "productId":productId,
        "rate":product.rate,
        "title":product.title,
        "remain":product.remain
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
        category: Category.fromJson(data['category'] ?? {}),
        likedNumber: data['likedNumber'] ?? 0,
        purchasesNumber: data['purchasesNumber'] ?? 0,
        remain: data['remain'] ?? 0,
        onSale: data['onSale'] ?? false,
        title: data['title'] ?? "",
        description: data['description'] ?? "",
        image: List<String>.from(data['image'] ?? []),
        price: data['price'] ?? 0.0,
        rate: data['rate'] ?? 0.0,
        label: data['label'] ?? "",
        productId: doc.id,
      );
    }).toList();
  }

  Stream<List<Product>> get productData {
    return productionCollection.snapshots().map((_productDataFromSnapshot));
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

  Future getDirection(MapboxMapController mapController,List<Line>existingLines,LatLng destination)async{
    String url ="https://api.mapbox.com/directions/v5/mapbox/driving/${destination.longitude},${destination.latitude};105.844655,20.980339?geometries=geojson&access_token=pk.eyJ1IjoidGh1Y2t1YmluIiwiYSI6ImNsbTYxYzJ1azB2MjQzcHA0NGR0YnIxMTUifQ.88hO1oKIFSZsljzkR2vP8w";
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

