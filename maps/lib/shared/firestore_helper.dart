import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps/models/place.dart';

class FirestoreHelper{
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static Future addPlace(Place place){
    var result = db.collection("places").add(place.toMap())
    .then((value) => print(value))
    .catchError((error)=>print(error));

    return result;
  }

  static Future<List<Place>> getUserPlaces(String uid) async{
    List<Place> places;

    QuerySnapshot docs = await db.collection("places").where("userId",isEqualTo: uid).get();

    places = docs.docs.map((data) => Place.fromMap(data.data(),data.id)).toList();

    return places;
  }
}