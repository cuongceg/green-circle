import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:hive/hive.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var box = Hive.box<CartItems>('cart_items');
  int count = 0;
  double sumCash = 0;
  List<bool> onSelected = List.filled(10, false);
  bool onDiscount = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        title: Text("My Cart (${box.length})",style: title2Black,),
        leading: IconButton(
            icon:const Icon(Icons.arrow_back),
          onPressed:(){
              Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: payProduct(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.grey.shade50,
      body:box.isNotEmpty?
      ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Container(
                          height: 175,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child:Column(
                            children: [
                              CheckboxListTile(
                                value: onSelected[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    onSelected[index]=!onSelected[index];
                                    onSelected[index]?sumCash+=box.getAt(index)!.price*box.getAt(index)!.quantity:
                                    sumCash-=box.getAt(index)!.price*box.getAt(index)!.quantity;
                                  });
                                },
                                checkColor: green1,
                                activeColor: Colors.white,
                                title: Text(box.getAt(index)!.category,style:title3Black,),
                                controlAffinity: ListTileControlAffinity.leading,
                              ),
                              ListTile(
                                  leading: Checkbox(
                                    value: onSelected[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        onSelected[index]=!onSelected[index];
                                        onSelected[index]?sumCash+=box.getAt(index)!.price*box.getAt(index)!.quantity:
                                        sumCash-=box.getAt(index)!.price*box.getAt(index)!.quantity;
                                      });
                                    },
                                    checkColor: green1,
                                    activeColor: Colors.white,
                                  ),
                                  onTap:(){
                                    setState(() {
                                      onSelected[index]=!onSelected[index];
                                      onSelected[index]?sumCash+=box.getAt(index)!.price*box.getAt(index)!.quantity:
                                      sumCash-=box.getAt(index)!.price*box.getAt(index)!.quantity;
                                    });
                                  },
                                  title: Text(box.getAt(index)!.title,style:body1Black,),
                                  subtitle: Text("${box.getAt(index)!.price.toStringAsFixed(0)} 000",style: subTitleFonts,),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          setState(() {
                                            if (box.getAt(index)!.quantity > 1) {
                                              box.getAt(index)!.quantity--;
                                              onSelected[index]?sumCash-=box.getAt(index)!.price:
                                              sumCash=sumCash;
                                            }
                                          });
                                        },
                                      ),
                                      Text('${box.getAt(index)!.quantity}'),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            box.getAt(index)!.quantity++;
                                            onSelected[index]?sumCash+=box.getAt(index)!.price:
                                            sumCash=sumCash;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            box.deleteAt(index);
                                            sumCash-=box.getAt(index)!.price*box.getAt(index)!.quantity;
                                          });
                                        },
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
            );
          }
          ):
      const Center(
        child: Text("Cart Items is empty"),
      ),
    );
  }

  Widget payProduct(){
    return Container(
      height: 126,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color:lightGray)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  value: onDiscount,
                  onChanged: (bool? value) {
                    setState(() {
                      onDiscount=!onDiscount;
                      if(onDiscount){
                        sumCash=0.85*sumCash;
                      }
                    });
                  },
                checkColor: green1,
                activeColor: Colors.white,
              ),
              const SizedBox(width: 10,),
              Text("Use Voucher",style: GoogleFonts.almarai(color:Colors.black,fontSize:16),),
            ],
          ),
          const Divider(
            color: lightGray,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: (){
                    sumCash=0.85*sumCash;
                  },
                  icon: const Icon(Icons.discount_sharp,color: green1,)
              ),
              const SizedBox(width: 10,),
              Text("Total Price: ${sumCash.toStringAsFixed(0)}.000",style: GoogleFonts.almarai(color:Colors.black,fontSize:16),),
              const SizedBox(width: 47,),
              Container(
                  height: 60,
                  width: 150,
                  decoration: const BoxDecoration(
                    color: green1,
                  ),
                  child: Center(
                    child: Text("Buy with voucher",style:GoogleFonts.almarai(color:Colors.white,fontSize:18),
                    ),
                  )),
            ],
          ),
        ],
      )
    );
  }
}

