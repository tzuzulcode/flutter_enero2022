class Movie{
  late String id;
  late String title;
  late String date;
  late double rating;
  String img = "https://as01.epimg.net/meristation/imagenes/2021/12/16/reportajes/1639644481_655591_1640209353_noticia_normal.jpg";

  Movie(this.id,this.title,this.date,this.rating);

  Movie.fromJSON(Map<String,dynamic> parsedJSON){
    id = parsedJSON['_id'];
    title = parsedJSON['title'];
    date = parsedJSON['date'];
    rating = double.parse(parsedJSON['rating'].toString());
  }
}