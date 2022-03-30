import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/shared/firestore_helper.dart';
import 'package:maps/widgets/place_dialog.dart';
import '../models/place.dart';


class MainMap extends StatefulWidget {
  final String uid;

  const MainMap(this.uid,Key? key) : super(key: key);

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
    FirestoreHelper.getUserPlaces(widget.uid)
    .then((places){

      for(Place place in places){
        addMarker(place.lat, place.lon, place.id!, place.name);
      }
      
      setState(() {
        markers = markers;
      });
    });
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_location),
        onPressed: (){
          Place place = Place("new", "", 0, 0, "", widget.uid);

          PlaceDialog dialog = PlaceDialog(place);
          showDialog(context: context, builder: (context)=>dialog.buildAlert(context));

        }
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