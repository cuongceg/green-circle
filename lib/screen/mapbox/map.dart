import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

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

  _showSnackBar(String name) {
    final snackBar = SnackBar(
        content: Text('Welcome to $name',style: snackBarFonts),backgroundColor: green1);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void _onSymbolTapped(Symbol symbol){
    LatLng? symbolPos=symbol.options.geometry;
    if(symbolPos!=null){
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target:symbolPos,
          zoom:18,
          tilt: 180.0,
        )
      ));
    }
    _showSnackBar(symbol.options.textField??"");
  }
  void _onStyleLoaded()async{
    mapController.addSymbol(
      const SymbolOptions(
        geometry:LatLng(21.004721, 105.844047),
        iconImage:"assets/images/cart_icon.png",
        iconColor:"#5CAF56",
        iconSize:1.7,
        textField:"Green Grocery Facility 1",
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
            textField:"Green Grocery Facility 2",
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
            textField:"Green Grocery Facility 3",
            textColor:"#5CAF56",
            textSize:10,
            iconOffset:Offset(0,-9)
        )
    );
  }

  Future getShortestPath()async{
    String url ="https://api.mapbox.com/directions/v5/mapbox/driving/105.844920,21.005000;105.844655,20.980339?geometries=geojson&access_token=pk.eyJ1IjoidGh1Y2t1YmluIiwiYSI6ImNsbTYxYzJ1azB2MjQzcHA0NGR0YnIxMTUifQ.88hO1oKIFSZsljzkR2vP8w";
    try{
      Dio().options.contentType=Headers.jsonContentType;
      Response<Map<String,dynamic>> responseData= await Dio().get<Map<String,dynamic>>(url);
      debugPrint('${responseData.statusCode}');
      if(responseData.statusCode==200){
        Map<String,dynamic>? data=responseData.data;
        if(data!=null){
          List<dynamic> routes=data['routes'];
          List<LatLng> coordinates = routes.expand((route) {
            List<dynamic> geometryCoordinates = route['geometry']['coordinates'];
            return geometryCoordinates.map((coordinate) => LatLng(coordinate[1], coordinate[0])); // Reversed for LatLng format
          }).toList();
          mapController.addLine(
            LineOptions(
              geometry: coordinates,
              lineColor: "#5CAF56",
              lineWidth:4.0
            )
          );
        }
      }
      return responseData.data;
    }catch(e){
      debugPrint("Error fetching shortest path: $e");
      return null;
    }
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
        body: ListView(
          children: [
            Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 400,
                  child: MapboxMap(
                    accessToken: accessToken,
                    initialCameraPosition: const CameraPosition(target: LatLng(21.005000,105.844920),zoom:17,tilt: 180.0,),
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
            _getPermission(),
            _getShortesPath()
          ],
        ));
  }
  Widget _getPermission() {
    return TextButton(
      child: const Text('get location permission'),
      onPressed: () async {
        var status = await Permission.locationWhenInUse.request();
        print("Location granted : $status");
        if(status==PermissionStatus.granted){
          mapController.onUserLocationUpdated;
        }
      },
    );
  }
  Widget _getShortesPath() {
    return TextButton(
      child: const Text('get shortest path'),
      onPressed: () {
        getShortestPath();
      }
    );
  }
}
