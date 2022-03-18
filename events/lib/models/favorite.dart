import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite{
  String? id;
  String eventId;
  String userId;
  Favorite(this.id,this.eventId,this.userId);

  Favorite.map(dynamic obj,this.id):
    eventId = obj["eventId"],
    userId = obj["userId"];
  
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {};

    if(id!=null){
      map['id'] = id;
    }

    map["eventId"] = eventId;
    map['userId'] = userId;

    return map;
  }
}