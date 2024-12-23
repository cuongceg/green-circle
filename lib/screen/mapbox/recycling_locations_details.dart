import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/services/database.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class RecyclingLocationDetail extends StatelessWidget {
  final String name;
  final LatLng destination;
  final MapboxMapController mapController;
  final List<Line>existingLine;
  const RecyclingLocationDetail({super.key,required this.destination,required this.name,required this.mapController,required this.existingLine});
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      width: width,
      decoration:BoxDecoration(
        color: Colors.white,
        borderRadius:const BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20)),
        border:Border.all(color: greenGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:10,bottom:5,left:10),
            child: Text(name,style:const TextStyle(fontSize:22,fontWeight:FontWeight.w700,color: green1),),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10),
            child: Row(
              children: [
                const Text("4 km",style:TextStyle(fontSize:17,fontWeight:FontWeight.w500,color: Colors.black),),
                Padding(
                  padding: const EdgeInsets.only(left:15),
                  child: TextButton.icon(
                    onPressed:(){
                      Database().getDirection(mapController,existingLine,destination);
                      Navigator.pop(context);
                    },
                    icon:const Icon(Icons.directions,color: Colors.white,),
                    label: const Text("Direction to this location",style:TextStyle(color: Colors.white),),
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(green1)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

