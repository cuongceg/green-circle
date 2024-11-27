import 'dart:io';
import 'package:flutter/material.dart';
import 'package:green_circle/screen/e_commerce/add_product.dart';
import 'package:green_circle/screen/e_commerce/like_product_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/widgets/e_commerce/product_card.dart';
import 'package:green_circle/services/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:green_circle/models/production.dart';

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
      debugPrint("Error loading user data: $e");
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
      debugPrint("Error saving image URL to Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Product>? productsInfo=Provider.of<List<Product>?>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
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
                                    leading: const Icon(Icons.camera),
                                    title: const Text('Take a photo'),
                                    onTap: () {
                                      _getImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo),
                                    title: const Text('Choose from gallery'),
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
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: _image != null
                            ? ClipOval(
                          child: Image.file(
                            _image!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                            : const Center(
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: green1,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "My Activity",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 150),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        size: 30,
                        color: green1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Hello, Phuong!!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/iconme1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Flexible(
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
                const SizedBox(height: 20),
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
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
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
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30),
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
                                padding: EdgeInsets.only(right: 30),
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
                                        const Color.fromARGB(255, 244, 255, 243),
                                        title: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.celebration,
                                                  color: Colors.green),
                                              const SizedBox(width: 8),
                                              const Text(
                                                '54 000',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                              const SizedBox(width: 8),
                                              Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.rotationY(
                                                    180 * 3.1415927 / 180),
                                                child: const Icon(
                                                  Icons.celebration_outlined,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        content: const Text(
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "My shop",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProduct()));
                        },
                        child: const Text('Explore shop',style:TextStyle(fontSize:15,color: green1),)
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "My favourite products",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LikeProductScreen()));
                        },
                        child: const Text('Explore products',style:TextStyle(fontSize:15,color: green1),)
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
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
                    itemCount: productsInfo?.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                          product: productsInfo![index], isHorizontal: true);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton.icon(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(green1),
                      fixedSize: WidgetStatePropertyAll<Size>(Size(200,40)),
                    ),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      "Sign out",
                      style: GoogleFonts.almarai(
                        fontSize: 18,
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