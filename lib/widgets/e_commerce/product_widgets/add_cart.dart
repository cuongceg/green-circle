import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/screen/e_commerce/check_out_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class AddToCart extends StatefulWidget {
  final Product product;
  const AddToCart({super.key,required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  var box = Hive.box<CartItems>('cart_items');
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color:lightGray)
      ),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          TextButton.icon(
              onPressed:(){},
              icon: const Icon(Icons.chat_outlined,color: green1,),
              label: const Text("Chat",style:TextStyle(color:Colors.black))),
          const VerticalDivider(
            indent: 4,
            endIndent: 4,
            color: mediumGray,
            thickness:1.5,
          ),
          TextButton.icon(
              onPressed:(){
                showModalBottomSheet(
                    context: context,
                    builder:(BuildContext context){
                      return BottomSheet(
                          onClosing: (){},
                          builder:(BuildContext context){
                            int currentNumber = 1;
                            return StatefulBuilder(
                                builder:(BuildContext context,setState){
                                  return Container(
                                    height:280,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(widget.product.image[0],height:150,width:150,),
                                            Expanded(
                                                child:ListTile(
                                                  title:Text("${widget.product.price.toStringAsFixed(0)} 000",style:title2,),
                                                  subtitle:Text("Remain:${widget.product.remain}",style:body1Black,),
                                                ))
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:10,vertical: 15),
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Quantity",
                                                style: GoogleFonts.almarai(fontSize:18,fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.left,
                                              ),
                                              Container(
                                                height:40,
                                                decoration:BoxDecoration(
                                                  border:Border.all(color:mediumGray,width:1.5),
                                                ),
                                                child:Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed:(){
                                                          if(currentNumber>1){
                                                            setState((){
                                                              currentNumber--;
                                                            });
                                                          }
                                                        },
                                                        icon:const Icon(Icons.remove,color:mediumGray,)),
                                                    Text("$currentNumber",style:label,),
                                                    IconButton(
                                                        onPressed:(){
                                                          setState((){
                                                            currentNumber++;
                                                          });
                                                        },
                                                        icon:const Icon(Icons.add,color:Colors.black54,))
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:10),
                                          child: Container(
                                            height: 45,
                                            width: width-20,
                                            color: green1,
                                            child: Center(
                                                child: TextButton(
                                                  child: Text("Add cart",style:GoogleFonts.almarai(color:Colors.white,fontSize:20),),
                                                  onPressed:(){
                                                    CartItems cartItems=CartItems(
                                                        productId: widget.product.productId,
                                                        price: widget.product.price,
                                                        imageUrl: widget.product.image[0],
                                                        title: widget.product.title,
                                                        quantity: currentNumber);
                                                    box.add(cartItems);
                                                    debugPrint(box.length.toString());
                                                    Navigator.pop(context);
                                                  },
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                            );
                          });
                    }
                );
              },
              icon: const Icon(Icons.add_shopping_cart_outlined,color: green1,),
              label: const Text("Add cart",style:TextStyle(color:Colors.black))),
          Container(
            color:green1,
            width:width/2.3,
            child:Center(
                child:TextButton(
                  onPressed:(){
                    showModalBottomSheet(
                        context: context,
                        builder:(BuildContext context){
                          return BottomSheet(
                              onClosing: (){},
                              builder:(BuildContext context){
                                int quantity = 1;
                                return StatefulBuilder(
                                    builder:(BuildContext context,setState){
                                      return Container(
                                        height:280,
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.network(widget.product.image[0],height:150,width:150,),
                                                Expanded(
                                                    child:ListTile(
                                                      title:Text("${widget.product.price.toStringAsFixed(0)} 000",style:title2,),
                                                      subtitle:Text("Remain:${widget.product.remain}",style:body1Black,),
                                                    ))
                                              ],
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.symmetric(horizontal:10,vertical: 15),
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Quantity",
                                                      style: GoogleFonts.almarai(fontSize:18,fontWeight: FontWeight.bold),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Container(
                                                      height:40,
                                                      decoration:BoxDecoration(
                                                        border:Border.all(color:mediumGray,width:1.5),
                                                      ),
                                                      child:Row(
                                                        children: [
                                                          IconButton(
                                                              onPressed:(){
                                                                if(quantity>1){
                                                                  setState((){
                                                                    quantity--;
                                                                  });
                                                                }
                                                              },
                                                              icon:const Icon(Icons.remove,color:mediumGray,)),
                                                          Text("$quantity",style:label,),
                                                          IconButton(
                                                              onPressed:(){
                                                                if(quantity<widget.product.remain){
                                                                  setState((){
                                                                    quantity++;
                                                                  });
                                                                }
                                                              },
                                                              icon:const Icon(Icons.add,color:Colors.black54,))
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:10),
                                              child: Container(
                                                height: 45,
                                                width: width-20,
                                                color: green1,
                                                child: Center(
                                                    child: TextButton(
                                                      child: Text("Buy with voucher",style:GoogleFonts.almarai(color:Colors.white,fontSize:20),),
                                                      onPressed:(){
                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckOutScreen(product: widget.product,quantity:quantity,)));
                                                      },
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                );
                              });
                        }
                    );
                  },
                  child: Text("Buy with voucher",style:GoogleFonts.almarai(color:Colors.white,fontSize:18),
                ),)
            ),
          )
        ],
      ),
    );
  }
}

