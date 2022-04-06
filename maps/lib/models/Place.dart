class Place{
  String? id;
  String name;
  double lat;
  double lon;
  String image;
  String userId;


  Place(this.id,this.name,this.lat,this.lon,this.image,this.userId);


  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'name':name,
      'lat':lat,
      'lon':lon,
      'image':image,
      'userId':userId
    };
  }

  Place.fromMap(dynamic obj,this.id):
    name=obj["name"],
    lat = double.parse(obj["lat"].toString()),
    lon = double.parse(obj["lat"].toString()),
    image = obj["image"],
    userId = obj["userId"];

}