import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToCart extends StatefulWidget {
  final Product product;
  const AddToCart({super.key,required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                            int currentColor = 0;
                            int currentNumber = 1;
                            return StatefulBuilder(
                                builder:(BuildContext context,setState){
                                  return Container(
                                    height:height/2.3,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(widget.product.image,height:150,width:150,),
                                            Expanded(
                                                child:ListTile(
                                                  title:Text("\$${widget.product.price}",style:title2,),
                                                  subtitle:Text("Remain:20",style:body1Black,),
                                                ))
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:10,vertical: 15),
                                          child: Text(
                                            "Color",
                                            style: GoogleFonts.almarai(fontSize:18,fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:10),
                                          child: Row(
                                            children: List.generate(
                                              widget.product.colors.length,
                                                  (index) => GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    currentColor = index;
                                                  });
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(milliseconds: 300),
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: currentColor == index
                                                        ? Colors.white
                                                        : widget.product.colors[index],
                                                    border: currentColor == index
                                                        ? Border.all(
                                                      color: widget.product.colors[index],
                                                    )
                                                        : null,
                                                  ),
                                                  padding: currentColor == index
                                                      ? const EdgeInsets.all(2)
                                                      : null,
                                                  margin: const EdgeInsets.only(right: 15),
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: widget.product.colors[index],
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
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
                child:Text("Buy with voucher",style:GoogleFonts.almarai(color:Colors.white,fontSize:18),)
            ),
          )
        ],
      ),
    );
  }
}

