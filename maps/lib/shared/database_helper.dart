import 'package:firebase_database/firebase_database.dart';
import 'package:maps/models/place.dart';

class DatabaseHelper{
  static final DatabaseReference db = FirebaseDatabase.instance.ref();


  static Future addPlace(Place place) async{
    await db.child(place.userId).push().set(place.toMap());
  }

  static Future deletePlace(Place place) async{
    await db.child(place.userId).child(place.id!).remove();
  }

  static void listenPlaces(String userId,Function updateData){
    db.child(userId).onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic,dynamic>;

      List<Place> places = [];

      print(data);

       data.forEach((key, value) {
          Map<dynamic,dynamic> p = value as Map<dynamic,dynamic>;
          Place place = Place.fromMap(p, key);
          places.add(place);
        });
      updateData(places);
    });
  }

  
}