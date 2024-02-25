import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key,required this.product,required this.quantity});
  final int quantity;
  final Product product;
  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool discount=false;
  @override
  Widget build(BuildContext context) {
    double widthR=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "My Cart",
          style:title2Black
        ),
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            icon: const Icon(Icons.chevron_left),
          ),
        ),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:15,top: 20,bottom:10),
            child: Text("Shipping address",style:title3Black,),
          ),
          Padding(
            padding: const EdgeInsets.only(left:20,right:15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Do Manh Cuong | 0985976571 \n710 Tan Mai \nThinh Liet,Hoang Mai,Ha Noi",style:body1Black,),
                TextButton(
                    onPressed:(){},
                    child: Text("Change",style: body1Green,)
                )
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:15,vertical: 20),
            child: Text(widget.product.category.title,style:title3Black,),
          ),
          ListTile(
            leading: Image.network(widget.product.image[0],height:70,width:70,),
            title:Text(widget.product.title,style:title3Black,),
            subtitle:Text('\$${widget.product.price}',style:subTitleFonts,),
            trailing: Text("x ${widget.quantity}",style:body1Black,),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left:15,right:15,top: 5,bottom: 0),
            child: Text("Delivery Methods",style:title3Black,),
          ),
          ListTile(
            title:Text("Speed",style:body1Black,),
            subtitle:Text("Receive products on the day 27/2-28/2",style:body1Black,),
            trailing: Text("30 000",style:title3Black,),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left:15,right:15,top:0,bottom: 0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Payment",style:title3Black,),
                TextButton(
                    onPressed:(){},
                    child:Text("Change",style: body1Green,),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on),
            title: Text("Payment upon delivery",style: body1Black,),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15,right:15,top:0,bottom: 0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discount code",style:title3Black,),
                TextButton(
                  onPressed:(){
                    setState(() {
                      discount=true;
                    });
                  },
                  child:Text("Apply",style: body1Green,),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15,right:15,top:10,bottom: 0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order",style:subTitleFonts,),
                Text('${widget.product.price.toStringAsFixed(0)} 000',style: title3Black,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15,right:15,top:10,bottom: 0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery",style:subTitleFonts,),
                Text("30 000",style:title3Black,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15,right:15,top:10,bottom: 0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",style:subTitleFonts,),
                Text(discount?'${((widget.product.price+30)*widget.quantity*0.8).toStringAsFixed(0)} 000':'${(widget.product.price+30).toStringAsFixed(0)*widget.quantity} 000',style:title3Black,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal:30),
            child: Container(
              height: 60,
              width:widthR,
              decoration:BoxDecoration(
                  color: green1,
                  borderRadius: BorderRadius.circular(25)
              ),
              child: TextButton(
                onPressed:(){
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                    backgroundColor:green1,
                    content:Text('Submit order successfully,check your order in Your Order',style:snackBarFonts),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child:Text(
                  "Submit order",
                  style: GoogleFonts.almarai(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
