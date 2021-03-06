import 'package:flutter/material.dart';
import '../shared/firestore_helper.dart';
import '../shared/database_helper.dart';
import '../models/place.dart';

class PlaceDialog{
  final txtName = TextEditingController();
  final txtLat = TextEditingController();
  final txtLon = TextEditingController();

  late final Place place;
  final bool newplace;

  PlaceDialog(this.place,this.newplace);


  Widget buildAlert(BuildContext context){
    txtName.text = place.name;
    txtLat.text = place.lat.toString();
    txtLon.text = place.lon.toString();

    return AlertDialog(
      title: Text("Place"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: const InputDecoration(
                hintText: "Name"
              ),
            ),
            TextField(
              controller: txtLat,
              decoration: const InputDecoration(
                hintText: "Latitude"
              ),
            ),
            TextField(
              controller: txtLon,
              decoration: const InputDecoration(
                hintText: "Longitud"
              ),
            ),
            ElevatedButton(
              onPressed: (){
                place.name = txtName.text;
                place.lat = double.parse(txtLat.text);
                place.lon = double.parse(txtLon.text);

                if(newplace){
                  FirestoreHelper.addPlace(place);
                  DatabaseHelper.addPlace(place);
                }else{
                  FirestoreHelper.updatePlace(place);
                }

                Navigator.pop(context);
              }, 
              child: const Text("Save")
            )
          ],
        ),
      ),
    );
  }
}
