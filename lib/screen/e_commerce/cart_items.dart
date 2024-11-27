import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_circle/models/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double sumCash = 0;
  List<bool> onSelected = List.filled(10, false);
  bool onDiscount = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        title: Consumer<CartItemProvider>(
          builder: (context, cartItemProvider, child) {
            final carts = cartItemProvider.cartItems;
            return Text("Cart Items: ${carts.length}", style: title2Black);
          },
        ),
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
      body: Consumer<CartItemProvider>(
        builder: (context, cartItemProvider, child) {
          final cartItems = cartItemProvider.cartItems;
          if(cartItems.isNotEmpty){
            return ListView.builder(
                itemCount: cartItems.length,
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
                                onSelected[index]?sumCash+=cartItems[index].product.price*cartItems[index].quantity:
                                sumCash-=cartItems[index].product.price*cartItems[index].quantity;
                              });
                            },
                            checkColor: green1,
                            activeColor: Colors.white,
                            title: Text(cartItems[index].product.category.title,style:title3Black,),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          ListTile(
                              leading: Checkbox(
                                value: onSelected[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    onSelected[index]=!onSelected[index];
                                    onSelected[index]?sumCash+=cartItems[index].product.price*cartItems[index].quantity:
                                    sumCash-=cartItems[index].product.price*cartItems[index].quantity;
                                  });
                                },
                                checkColor: green1,
                                activeColor: Colors.white,
                              ),
                              onTap:(){
                                setState(() {
                                  onSelected[index]=!onSelected[index];
                                  onSelected[index]?sumCash+=cartItems[index].product.price*cartItems[index].quantity:
                                  sumCash-=cartItems[index].product.price*cartItems[index].quantity;
                                });
                              },
                              title: Text(cartItems[index].product.title,style:body1Black,),
                              subtitle: Text("${cartItems[index].product.price.toStringAsFixed(0)} 000",style: subTitleFonts,),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (cartItems[index].quantity > 1) {
                                          cartItems[index].quantity--;
                                          onSelected[index]?sumCash-=cartItems[index].product.price:
                                          sumCash=sumCash;
                                        }
                                      });
                                    },
                                  ),
                                  Text('${cartItems[index].quantity}'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        cartItems[index].quantity++;
                                        onSelected[index]?sumCash+=cartItems[index].product.price:
                                        sumCash=sumCash;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        cartItemProvider.removeCartItem(cartItems[index]);
                                        sumCash-=cartItems[index].product.price*cartItems[index].quantity;
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
            );
          }else{
            return Center(
              child: Text("No items in cart",style: body1Black,),
            );
          }
        },
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

