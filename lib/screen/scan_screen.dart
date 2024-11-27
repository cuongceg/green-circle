import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_circle/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? _selectedImage;
  bool hasResult=false,onPressed=false;
  final _isPlayerReady = false;
  late String _initialVideoId;
  late String _initialVideoId2;
  late String _initialVideoId3;
  late YoutubePlayerController _controller;
  late YoutubePlayerController _controller2;
  late YoutubePlayerController _controller3;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  int index=-1;

  @override
  void initState(){
    super.initState();
    _initialVideoId = YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=QwwlsCMeSmM&t=22s')!;
    _initialVideoId2 = YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=Tzi_uTNT9_E')!;
    _initialVideoId3 = YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=N4aT-mN8Bb8')!;
    _controller = YoutubePlayerController(
        initialVideoId: _initialVideoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        )
    )..addListener(listener);
    _controller2 = YoutubePlayerController(
        initialVideoId: _initialVideoId2,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        )
    )..addListener(listener);
    _controller3 = YoutubePlayerController(
        initialVideoId: _initialVideoId3,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        )
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        mainAxisAlignment:MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          Center(
            child: Container(
              height: 200,
              width: width-180,
              decoration:BoxDecoration(
                border: Border.all(),
              ),
              child:_selectedImage!=null?Image(image: FileImage(File(_selectedImage!.path))):const Icon(Icons.add,size:30,color: Colors.grey,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10,top: 20,bottom:20),
            child: Row(
              children:[
                Text("Upload from",style:title3Black,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10),
                  child: TextButton.icon(
                    onPressed:(){
                      _pickImageFromCamera();
                      setState(() {
                        onPressed=false;
                        hasResult=false;
                      });
                    },
                    style:const ButtonStyle(
                        iconColor:WidgetStatePropertyAll<Color>(Colors.white),
                        backgroundColor:WidgetStatePropertyAll<Color>(green1)
                    ),
                    icon: const Icon(Icons.camera),
                    label: Text("Camera",style:snackBarFonts,),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10),
                  child: TextButton.icon(
                    onPressed:(){
                      _pickImageFromGallery();
                      setState(() {
                        onPressed=false;
                        hasResult=false;
                      });
                    },
                    style:const ButtonStyle(
                        iconColor:WidgetStatePropertyAll<Color>(Colors.white),
                        backgroundColor:WidgetStatePropertyAll<Color>(green1)
                    ),
                    icon: const Icon(Icons.image),
                    label: Text("Gallery",style:snackBarFonts,),
                  ),
                ),
              ],
            ),
          ),
          Center(
              child:GestureDetector(
                onTap: (){
                  setState(() {
                    onPressed=true;
                    if(index<0){
                      index++;
                    }
                  });
                  Timer(const Duration(seconds:2), () {
                    setState(() {
                      hasResult = true;
                    });
                  });
                },
                child: Container(
                  height:40,
                  width: 285,
                  decoration:BoxDecoration(
                    color: green1,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text("Check ",style:GoogleFonts.almarai(fontSize:18,color:Colors.white,fontWeight: FontWeight.w700),),
                  ),
                ),
              )
          ),
          const SizedBox(height: 20,),
          onPressed?hasResult?
          Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 0),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:5,left:10),
                    child: Text("Ban dang co:",style:title3Black,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom : 5,left:15),
                    child: Text("- 2 chai nhua\n- 6 nap chai",style:label,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:10,left:10),
                    child: Text("San pham 1: Xe o to lam tu vo chai tai che",style:title3Black,),
                  ),
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5,bottom : 5,left:15),
                    child: Text("Ban con thieu\n- 2 day chun\n- 1 lo xo\n- 3 thanh tre",style:label,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:10,left:10),
                    child: Text("San pham 2: Heo tiet kiem lam tu vo chai tai che",style:title3Black,),
                  ),
                  YoutubePlayer(
                    controller: _controller3,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5,bottom : 5,left:15),
                    child: Text("Ban con thieu\n- 4 mieng vai mau\n- Vai len\n- 2 tam nhua cung",style:label,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:10,left:10),
                    child: Text("San pham 3: Den pin lam tu vo chai tai che",style:title3Black,),
                  ),
                  YoutubePlayer(
                    controller: _controller2,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5,bottom : 5,left:15),
                    child: Text("Ban con thieu\n- 6 day dien\n- 1 nut bam\n- 1 bong den\n - 1 cuc pin",style:label,),
                  ),
                ],
              )
          )
              :const Center(
            child: CircularProgressIndicator(
              color: green1,
              strokeWidth: 4.0,
            ),
          ):const SizedBox(),
        ],
      ),
    );
  }
  Future _pickImageFromGallery()async{
    final returnedImage= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(returnedImage == null)return;
    setState(() {
      _selectedImage=File(returnedImage.path);
    });
  }
  Future _pickImageFromCamera()async{
    var returnedImage= await ImagePicker().pickImage(source: ImageSource.camera);
    if(returnedImage == null)return;
    setState(() {
      _selectedImage=File(returnedImage.path);
    });
  }
}