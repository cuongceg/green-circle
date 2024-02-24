import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_circle/models/production.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search ='';
  TextEditingController searchEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Product>products=Provider.of(context);
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency:true,
        leading:IconButton(
          icon: const Icon(Icons.arrow_back,size: 30,),
          onPressed:(){
            Navigator.pop(context);
          },
        ),
        title:TextField(
            controller: searchEditingController,
            onChanged: (text){
              search=text;
            },
            decoration:InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius:borderRadius,
                    borderSide:borderSideWhite
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius:borderRadius,
                    borderSide:borderSideGreen
                ),
                fillColor: lightGray,
                filled: true,
                labelText:"Search your favourite products",
                labelStyle:GoogleFonts.outfit(fontSize:15,color:Colors.black,fontWeight:FontWeight.w500))
        ),
      ),
    );
  }
}
