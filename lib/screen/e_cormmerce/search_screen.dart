import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/screen/e_cormmerce/main_screen.dart';
import 'package:green_circle/services/database.dart';
import 'package:green_circle/widgets/e_cormmerce/product_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search ='';
  List<Product>searchedProducts=[];
  TextEditingController searchEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Product>?products=Provider.of<List<Product>?>(context);
    if(products!=null&&search!=""){
      for(Product product in products){
        if(product.title.contains(search)){
          searchedProducts.add(product);
        }
      }
    }
    Future<List<Product>> suggestionsCallback(String pattern) async =>
        Future<List<Product>>.delayed(
          const Duration(milliseconds: 300),
              () => products!.where((product) {
            final nameLower = product.title.toLowerCase().split(' ').join('');
            final patternLower = pattern.toLowerCase().split(' ').join('');
            return nameLower.contains(patternLower);
          }).toList(),
        );
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency:true,
        leading:IconButton(
          icon: const Icon(Icons.arrow_back,size: 30,),
          onPressed:(){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const MainScreen()));
          },
        ),
        title:Text("Search products",style:title3Black,),
      ),
      body: StreamBuilder(
        stream: Database().productData,
        builder:(context,snapshot){
          if(snapshot.hasData){
            return ListView(
                children:[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:35,vertical:10),
                    child: TypeAheadField(
                      controller: searchEditingController,
                      builder: (context, controller, focusNode) => TextField(
                          controller: controller,
                          focusNode: focusNode,
                          autofocus: true,
                          onChanged:(text){
                            search=text;
                          },
                          decoration:InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:borderRadius,
                                  borderSide:borderSideWhite
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:borderRadius,
                                  borderSide:const BorderSide(color: green4)
                              ),
                              fillColor: lightGray,
                              filled: true,
                              labelText:"Search your favourite products",
                              suffix:InkWell(
                                child:const Icon(Icons.search),
                                onTap:(){
                                  searchedProducts.removeRange(0,searchedProducts.length);
                                  setState(() {
                                    search=search;
                                  });
                                },
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelStyle:GoogleFonts.outfit(fontSize:15,color:Colors.black,fontWeight:FontWeight.w500))
                      ),
                      suggestionsCallback: suggestionsCallback,
                      itemBuilder: (context, product) => ListTile(
                        title: Text(product.title,style:body1Black,),
                        subtitle:Text('${product.price.toStringAsFixed(0)} 000',),
                      ),
                      onSelected: (suggestion) {
                        searchedProducts.removeRange(0, searchedProducts.length);
                        setState(() {
                          search=suggestion.title;
                        });
                        debugPrint(search);
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  searchedProducts.isEmpty?
                  Center(
                      child:Text(search!=" "?"Can't find the item you're looking for":"",style:title3Black,)
                  ):
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing:20,
                      mainAxisSpacing: 20,
                      childAspectRatio:0.85,
                    ),
                    itemCount: searchedProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: searchedProducts[index],isHorizontal: false,);
                    },
                  ),]
            );
          }
          else if(snapshot.connectionState==ConnectionState.waiting){
            return const CircularProgressIndicator(
              color: green1,
              strokeWidth: 4.0,
            );
          }
          else {
            return Center(
              child:Text("${snapshot.error}",style:title3Black,)
            );
          }
        },
      ),
    );
  }
}
