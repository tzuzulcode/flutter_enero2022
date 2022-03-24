import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MainMap(),
    );
  }
}


class MainMap extends StatefulWidget {
  const MainMap({ Key? key }) : super(key: key);

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {

  List<Marker> markers = [];

  final CameraPosition position = const CameraPosition(
    target: LatLng(41.9028, 12.4964),
    zoom: 10
  );

  @override
  void initState() {
    addMarker(41.9028, 12.4964, "current", "Estamos aquí");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapas")),
      body: Container(
        child: GoogleMap(
          initialCameraPosition: position,
          markers: Set<Marker>.of(markers),
          )
        ),
    );
  }

  void addMarker(latitude,long, String markerId, String markerTitle){
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: LatLng(latitude,long),
      infoWindow: InfoWindow(title: markerTitle),
      icon: (markerId=="current")?BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed):
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
    );

    markers.add(marker);

    setState(() {
      markers = markers;
    });
  }

}