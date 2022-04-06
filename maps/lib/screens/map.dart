import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/shared/firestore_helper.dart';
import '../shared/database_helper.dart';
import 'package:maps/widgets/manage_places.dart';
import 'package:maps/widgets/place_dialog.dart';
import '../models/place.dart';
import 'dart:async';


class MainMap extends StatefulWidget {
  final String uid;

  const MainMap(this.uid,Key? key) : super(key: key);

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> with WidgetsBindingObserver {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];

  final CameraPosition position = const CameraPosition(
    target: LatLng(41.9028, 12.4964),
    zoom: 10
  );

  void updateData(List<Place> places){
    addMarker(places);
  }

  @override
  void initState() {

    markers = [];

    DatabaseHelper.listenPlaces(widget.uid, updateData);

    WidgetsBinding.instance!.addObserver(this);
    // FirestoreHelper.getUserPlaces(widget.uid)
    // .then((places){

    //   for(Place place in places){
    //     addMarker(place.lat, place.lon, place.id!, place.name);
    //   }
      
    //   setState(() {
    //     markers = markers;
    //   });
    // });
    super.initState();
  }

  // FutureOr refreshData(dynamic value){

  //   print("Refresh");
  //   FirestoreHelper.getUserPlaces(widget.uid)
  //   .then((places){

  //     setState(() {
  //       markers = [];
  //     });

  //     addMarker(41.9028, 12.4964, "current", "Estamos aquí");

  //     for(Place place in places){
  //       addMarker(place.lat, place.lon, place.id!, place.name);
  //     }
      
  //   });
  // }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapas"),
        actions: [
          IconButton(
            onPressed: (){
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context)=>ManagePlaces(widget.uid, null)
              );

              Navigator.push(context, route);
            }, 
            icon: Icon(Icons.list)
          )
        ],
      ),
      body: Container(
        child: GoogleMap(
          initialCameraPosition: position,
          markers: Set<Marker>.of(markers),
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_location),
        onPressed: (){
          Place place = Place("new", "", 0, 0, "", widget.uid);

          PlaceDialog dialog = PlaceDialog(place,true);
          showDialog(context: context, builder: (context)=>dialog.buildAlert(context));

        }
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyles);
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  void addMarker(List<Place> places){
    List<Marker> markersList = [];
    
    Marker actual = Marker(
      markerId: const MarkerId("current"),
      position: const LatLng(41.9028, 12.4964),
      infoWindow: const InfoWindow(title: "Estamos aquí"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
    );

    markersList.add(actual);

    print(places);

    for(Place place in places){
      final marker = Marker(
        markerId: MarkerId(place.id!),
        position: LatLng(place.lat,place.lon),
        infoWindow: InfoWindow(title: place.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
      );
      markersList.add(marker);
    }


    print(markersList);

    setState(() {
      markers = markersList;
    });
  }

  // lifecycle
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        final GoogleMapController controller = await _controller.future;
        onMapCreated(controller);
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState detached');
        break;
    }
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  .......
]''';
}