import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:green_circle/screen/mapbox/recycling_locations_details.dart';
import 'package:green_circle/screen/screen_options.dart';
import 'package:green_circle/services/database.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullMap extends StatefulWidget {
  const FullMap({super.key});

  @override
  State<FullMap> createState() => _FullMapState();
}

class _FullMapState extends State<FullMap> {
  String accessToken = "";
  late MapboxMapController mapController;
  MapboxMap? mapboxMap;

  _onMapCreated(MapboxMapController controller){
    mapController=controller;
    controller.onSymbolTapped.add(_onSymbolTapped);
  }

  _showBottomModalSheet(String name){
    showModalBottomSheet(
        context: context,
        builder:(BuildContext context){
          return RecyclingLocationDetail(name: name,mapController: mapController,);
        });
  }

  void _onSymbolTapped(Symbol symbol){
    LatLng? symbolPos=symbol.options.geometry;
    if(symbolPos!=null){
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target:symbolPos,
          zoom:15,
          tilt: 270.0,
        )
      ));
    }
    _showBottomModalSheet(symbol.options.textField??'');
  }

  void _onStyleLoaded()async{
    mapController.addSymbol(
      const SymbolOptions(
        geometry:LatLng(21.004721, 105.844047),
        iconImage:"assets/images/cart_icon.png",
        iconColor:"#5CAF56",
        iconSize:1.7,
        textField:"Green Recycling Location Facility 1",
        textColor:"#5CAF56",
        textSize:10,
        iconOffset:Offset(0,-9)
      )
    );
    mapController.addSymbol(
        const SymbolOptions(
            geometry:LatLng(20.981340, 105.853674),
            iconImage:"assets/images/cart_icon.png",
            iconColor:"#5CAF56",
            iconSize:1.7,
            textField:"Green Recycling Location Facility 2",
            textColor:"#5CAF56",
            textSize:10,
            iconOffset:Offset(0,-9)
        )
    );
    mapController.addSymbol(
        const SymbolOptions(
            geometry:LatLng(20.963949, 105.831959),
            iconImage:"assets/images/cart_icon.png",
            iconColor:"#5CAF56",
            iconSize:1.7,
            textField:"Green Recycling Location Facility 3",
            textColor:"#5CAF56",
            textSize:10,
            iconOffset:Offset(0,-9)
        )
    );
  }
  @override
  void initState() {
    super.initState();
    accessToken =
    "sk.eyJ1IjoidGh1Y2t1YmluIiwiYSI6ImNsc29mbDIwajBjdnQybHA5aDY3N3cwejcifQ.uWPAB2GAOwDfBujnEzCt8A";
    tokenkey();
  }
  String tokenKey = '';
  Future<void> tokenkey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenKey = prefs.getString('tokenkey') ?? "";
  }

  @override
  void dispose(){
    mapController.onSymbolTapped.remove(_onSymbolTapped);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Stack(
          children: [
            Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: MapboxMap(
                    accessToken: accessToken,
                    initialCameraPosition: const CameraPosition(target: LatLng(21.005000,105.844920),zoom:17,tilt: 270.0,),
                    onMapCreated: _onMapCreated,
                    onStyleLoadedCallback: _onStyleLoaded,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
                      ),
                    },
                    annotationOrder:const [
                      AnnotationType.fill,
                      AnnotationType.line,
                      AnnotationType.symbol,
                      AnnotationType.circle,
                    ],
                    myLocationEnabled: true,
                    myLocationTrackingMode: MyLocationTrackingMode.Tracking,
                  )),
            ),
            Positioned(
                left: 10,
                top: 50,
                child:IconButton(
                  icon:Icon(Icons.arrow_back),
                  onPressed:(){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const ScreenOptions()));
                  },
                )
            ),
            Positioned(
              right: 10,
                bottom: 20,
                child:Container(
                  color: lightGray,
                  width: 50,
                  height: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon:const Icon(Icons.directions,color:green1,size:35,),
                          onPressed: () {
                            Database().getShortestPath(mapController);
                          }
                      ),
                      IconButton(
                          icon:const Icon(Icons.location_on,color:green1,size:35,),
                          onPressed: () {
                          }
                      ),
                    ],
                  ),
                ))
          ],
        )
        );
  }
}
