import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/category.dart';
import 'package:green_circle/screen/e_commerce/chat_bot.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        children: [
          const SizedBox(height:50,),
          Center(
            child:Text("Messages",style: title2Black,),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder:(context, index) {
                return Padding(
                  padding: index == 0?const EdgeInsets.only(bottom: 15,top:0): const EdgeInsets.symmetric(vertical:15),
                  child: ListTile(
                    leading:CircleAvatar(
                      backgroundImage: AssetImage(categories[index].image),
                      radius: 30,
                    ),
                    title:Text(categories[index].title,style: body1Black,),
                    subtitle: Text(index==0?"online":"offline",style:index==0?body1Green:subTitleFonts,),
                    trailing: const Icon(Icons.chevron_right),
                    onTap:(){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SectionStreamChat()));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
