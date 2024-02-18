import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'dart:convert';
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
    controller.onCircleTapped.add(_onCircleTapped);
    controller.onSymbolTapped.add(_onSymbolTapped);
    controller.onFillTapped.add(_onFillTapped);
  }

  _showSnackBar(String type, String id) {
    final snackBar = SnackBar(
        content: Text('Tapped $type $id',
            style: snackBarFonts),
        backgroundColor: green1);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onCircleTapped(Circle circle){
    _showSnackBar("circle",circle.id);
  }
  void _onSymbolTapped(Symbol symbol){
    _showSnackBar("symbol",symbol.id);
  }
  void _onFillTapped(Fill fill){
    _showSnackBar("fill",fill.id);
  }
  void _addLocation(MapboxMapController controller){
    const LatLng leftCorner=LatLng(21.004721, 105.844047);
    const double latIncrement= 50/110574;//height of rectangle location is 50
    final double lngIncrement=  30 / (111320 * cos(leftCorner.latitude * pi / 180));//width of rectangle location is 30
    final List<LatLng> rectangleCoordinates = [
      leftCorner, // Top left corner
      LatLng(leftCorner.latitude + latIncrement, leftCorner.longitude), // Top right corner
      LatLng(leftCorner.latitude + latIncrement, leftCorner.longitude + lngIncrement), // Bottom right corner
      LatLng(leftCorner.latitude, leftCorner.longitude + lngIncrement), // Bottom left corner
    ];
    Map<String, dynamic> geoJsonSource = jsonDecode('''
  {
    "type": "FeatureCollection",
    "features": [{
      "type": "Feature",
      "geometry": {
        "type": "Polygon",
        "id": 0
        "coordinates": [[
          [${rectangleCoordinates[0].longitude}, ${rectangleCoordinates[0].latitude}],
          [${rectangleCoordinates[1].longitude}, ${rectangleCoordinates[1].latitude}],
          [${rectangleCoordinates[2].longitude}, ${rectangleCoordinates[2].latitude}],
          [${rectangleCoordinates[3].longitude}, ${rectangleCoordinates[3].latitude}],
          [${rectangleCoordinates[0].longitude}, ${rectangleCoordinates[0].latitude}]
        ]]
      },
      "properties": {
      "name": "Feature 1",
      "category": "Green",}
    }]
  }
''');
    controller.addGeoJsonSource('green-id',geoJsonSource);
    controller.addFillLayer(
      "green_id","green_id",
      const FillLayerProperties(
          fillColor:[Expressions.interpolate, ['exponential', 0.5], [Expressions.zoom], 11, 'red', 18, 'green'],
          fillOpacity: 0.8
      )
    );
  }
  void _onStyleLoaded()async{
    //await mapController.addGeoJsonSource(sourceId, geojson)
    mapController.addCircle(
      const CircleOptions(
        geometry:LatLng(21.004721, 105.844047),
        circleColor:"#5CAF56",
        circleStrokeWidth: 2,
        circleRadius:5,
      )
    );
    const LatLng leftCorner=LatLng(21.004721, 105.844047);
    const double latIncrement= 5000/110574;//height of rectangle location is 50
    final double lngIncrement=  3000/ (111320 * cos(leftCorner.latitude * pi / 180));//width of rectangle location is 30
    final List<LatLng> rectangleCoordinates = [
      leftCorner, // Top left corner
      LatLng(leftCorner.latitude + latIncrement, leftCorner.longitude), // Top right corner
      LatLng(leftCorner.latitude + latIncrement, leftCorner.longitude + lngIncrement), // Bottom right corner
      LatLng(leftCorner.latitude, leftCorner.longitude + lngIncrement), // Bottom left corner
    ];
    Map<String, dynamic> geoJsonSource = jsonDecode('''
  {
    "type": "FeatureCollection",
    "features": [{
      "type": "Feature",
      "geometry": {
        "type": "Polygon",
        "id": 0
        "coordinates": [[
          [${rectangleCoordinates[0].longitude}, ${rectangleCoordinates[0].latitude}],
          [${rectangleCoordinates[1].longitude}, ${rectangleCoordinates[1].latitude}],
          [${rectangleCoordinates[2].longitude}, ${rectangleCoordinates[2].latitude}],
          [${rectangleCoordinates[3].longitude}, ${rectangleCoordinates[3].latitude}],
          [${rectangleCoordinates[0].longitude}, ${rectangleCoordinates[0].latitude}]
        ]]
      },
      "properties": {
      "name": "Feature 1",
      "category": "Green",}
    }]
  }
''');
    await mapController.addGeoJsonSource('green-id',geoJsonSource);
    mapController.addFill(
      FillOptions(
          geometry: [rectangleCoordinates],
          fillColor:"#AED038",
          fillOutlineColor: "#000000",
      ),
    );
    await mapController.addFillLayer(
        "green_id","green_id",
        const FillLayerProperties(
            fillOpacity: 0.8
        )
    );
    _addLocation(mapController);
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
    mapController.onCircleTapped.remove(_onCircleTapped);
    mapController.onSymbolTapped.remove(_onSymbolTapped);
    mapController.onFillTapped.remove(_onFillTapped);
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
          ],
        ));
  }
  Widget _getPermission() {
    return TextButton(
      child: const Text('get location permission'),
      onPressed: () async {
        var status = await Permission.locationWhenInUse.request();
        print("Location granted : $status");
      },
    );
  }
}
