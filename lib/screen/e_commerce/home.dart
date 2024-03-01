import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/services/database.dart';
import 'package:provider/provider.dart';
import 'package:green_circle/widgets/e_commerce/home_slider.dart';
import 'package:green_circle/widgets/e_commerce/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlide = 0;
  @override
  Widget build(BuildContext context) {
    List<Product>? productsInfo=Provider.of<List<Product>?>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: StreamBuilder(
              stream:Database().productData,
              builder:(context,snapshot){
                if(snapshot.hasData){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeSlider(
                        onChange: (value) {
                          setState(() {
                            currentSlide = value;
                          });
                        },
                        currentSlide: currentSlide,
                      ),
                      const SizedBox(height:10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Flash sale", style:title2),
                            TextButton(
                              onPressed: () {},
                              child: Text("See all",style:body1Green,),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height:175,
                        width: 500,
                        child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount:productsInfo!.length,
                            itemBuilder: (context,index){
                              return ProductCard(product: productsInfo[index], isHorizontal:true);
                            }),
                      ),
                      Padding(
                        padding:const EdgeInsets.symmetric(horizontal:10,vertical:20),
                        child:Text("Daily Discover",style:title2,),
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio:0.85,
                        ),
                        itemCount: productsInfo.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: productsInfo[index],isHorizontal: false,);
                        },
                      ),
                    ],
                  );
                }
                else if(snapshot.connectionState==ConnectionState.waiting){
                  return const CircularProgressIndicator(
                    color: green1,
                    strokeWidth: 4.0,
                  );
                }
                else{
                  return Text("Error:${snapshot.error}",style:title2Black,);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}