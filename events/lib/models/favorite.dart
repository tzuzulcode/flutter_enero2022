import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite{
  String? _id;
  String _eventId;
  String _userId;
  Favorite(this._id,this._eventId,this._userId);

  Favorite.map(dynamic obj):
    _id = obj["id"],
    _eventId = obj["eventId"],
    _userId = obj["userId"];
  
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {};

    if(_id!=null){
      map['id'] = _id;
    }

    map["eventId"] = _eventId;
    map['userId'] = _userId;

    return map;
  }
}