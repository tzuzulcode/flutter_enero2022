import '../models/event_detail.dart';
import '../models//favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper{
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static Future addFavorite(EventDetail eventDetail,String uid){
    Favorite fav = Favorite(null, eventDetail.id!, uid);

    var result = db.collection("favorites").add(fav.toMap())
    .then((value) => print(value))
    .catchError((error)=>print(error));

    return result;
  }
}