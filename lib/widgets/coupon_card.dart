import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:coupon_uikit/coupon_uikit.dart';

class Coupon extends StatefulWidget {
  final int discountPercent,maxDiscount;
  final DateTime outOfDate;
  const Coupon({super.key,required this.discountPercent,required this.maxDiscount,required this.outOfDate});

  @override
  State<Coupon> createState() => _CouponState();
}

class _CouponState extends State<Coupon> {
  bool onSave=false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10,right:10,bottom:5),
      child: CouponCard(
        firstChild:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Discount ${widget.discountPercent}% max discount ${widget.maxDiscount}.000 VND",style:const TextStyle(fontSize:15,fontWeight:FontWeight.w600,color: Colors.black),),
            const Text("12/2/2024-20/2/2004",style:TextStyle(fontSize:12,color:Colors.grey),)
          ],
        ),
        secondChild:Container(
          decoration: BoxDecoration(
              color: onSave?Colors.white:green4,
              border: Border.all(color:onSave?green4:Colors.white)
          ),
          height: 35,
          width: 80,
          child: Center(
            child: TextButton(
              child:Text(onSave?"Use it":'Save',style:TextStyle(color:onSave?green4:Colors.white,fontSize:13),),
              onPressed:(){
                setState(() {
                  onSave=true;
                });
              },
            ),
          ),
        ),
        width:240,
        height:80,
        curvePosition:140,
        curveAxis: Axis.vertical,
        border:const BorderSide(color: green1),
      ),
    );
  }
}
