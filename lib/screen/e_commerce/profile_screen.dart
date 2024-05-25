import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/widgets/e_commerce/product_card.dart';
import 'package:green_circle/services/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';

class MeScreen extends StatefulWidget {
  const MeScreen({Key? key}) : super(key: key);

  @override
  State<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  String? userName;
  File? _image;
  late String userId;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });

      // Load user's image URL from Firestore
      await _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'];
          imageUrl = userDoc['image_url'];
        });
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Upload image to Firebase Storage
      await _uploadImageToFirebase();
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (_image != null) {
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images/$userId/${DateTime.now()}');

      await storageReference.putFile(_image!);

      // Get download URL
      final imageUrl = await storageReference.getDownloadURL();

      // Save image URL to Firestore
      await _saveImageUrlToFirestore(imageUrl);
    }
  }

  Future<void> _saveImageUrlToFirestore(String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .set({'image_url': imageUrl}, SetOptions(merge: true));
    } catch (e) {
      print("Error saving image URL to Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text('Take a photo'),
                                    onTap: () {
                                      _getImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.photo),
                                    title: Text('Choose from gallery'),
                                    onTap: () {
                                      _getImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: _image != null
                            ? ClipOval(
                                child: Image.file(
                                  _image!,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Center(
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: green1,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "My Activity",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 90),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: green1,
                          width: 2,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          size: 30,
                          color: green1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Hello, $userName!!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/iconme1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You just got a reward",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
// Convert
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 42),
                                child: Icon(
                                  Icons.favorite_border_rounded,
                                  color: Colors.green,
                                ),
                              ),
                              Icon(
                                Icons.share,
                                color: Colors.green,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 43),
                                child: Icon(
                                  Icons.star_border_outlined,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  '500 likes',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 16),
                                ),
                              ),
                              Text(
                                '10 shares',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 16),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Text(
                                  '30 stars',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            Color.fromARGB(255, 244, 255, 243),
                                        title: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.celebration,
                                                  color: Colors.green),
                                              SizedBox(width: 8),
                                              Text(
                                                '54 000',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                              SizedBox(width: 8),
                                              Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.rotationY(
                                                    180 * 3.1415927 / 180),
                                                child: Icon(
                                                  Icons.celebration_outlined,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        content: Text(
                                          'is the amount you donate to the funds!',
                                          style: TextStyle(fontSize: 14),
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Close',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Convert",
                                  style: GoogleFonts.almarai(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "My Purchases",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: green5,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "To Pay",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: green1,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: green5,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "To Ship",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: green1,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: green5,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "To Receive",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: green1,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: green5,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "To Rate",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: green1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Buy Again",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 180,
                  width: 500,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                          product: products[index], isHorizontal: true);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton.icon(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(green1),
                      fixedSize: MaterialStatePropertyAll<Size>(Size(285, 55)),
                    ),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: Text(
                      "Sign out",
                      style: GoogleFonts.almarai(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      AuthService().signOut();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
