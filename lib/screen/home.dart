import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/widgets/home_slider.dart';
import 'package:green_circle/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlide = 0;
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
                      Text("Flash sale", style: heading2),
                      TextButton(
                        onPressed: () {},
                        child: Text("See all",style:title,),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height:200,
                  width: 500,
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:products.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                                  height:160,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    border:Border.all(color:mediumGray,width: 2.0),
                                    borderRadius:BorderRadius.circular(12)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        products[index].image,
                                        width: 150,
                                        height: 95,
                                      ),
                                      const Divider(),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(products[index].title,style:titleProduct,)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical:8,horizontal:5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${products[index].price}",style:price,),
                                            IconButton(
                                                onPressed:(){},
                                                icon: Image.asset("assets/images/heart_icon.png",height:30,width:30,)
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        );
                      }),
                ),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal:10,vertical:20),
                  child:Text("Daily Discover",style:heading2Green,),
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index],isHorizontal: false,);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}