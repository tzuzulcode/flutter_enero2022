import 'package:flutter/material.dart';
import '../shared/firestore_helper.dart';
import './place_dialog.dart';
import '../models/place.dart';

class ManagePlaces extends StatelessWidget {
  final String uid;
  const ManagePlaces(this.uid,Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage places")),
      body: PlacesList(uid,null),
    );
  }
}

class PlacesList extends StatefulWidget {
  final String uid;
  const PlacesList(this.uid,Key? key) : super(key: key);

  @override
  State<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {

  List<Place> places = [];


  @override
  void initState() {
    // TODO: implement initState

    FirestoreHelper.getUserPlaces(widget.uid)
    .then((places){
      setState(() {
        this.places = places;
      });
    })
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: 
    );
  }
}