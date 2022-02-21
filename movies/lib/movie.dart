class Movie{
  String id;
  String title;
  String date;
  double rating;

  Movie(this.id,this.title,this.date,this.rating);

  Movie.fromJSON(Map<String,dynamic> parsedJSON){
    this.id = parsedJSON['_id'];
    this.title = parsedJSON['title'];
    this.date = parsedJSON['date'];
    this.rating = parsedJSON['rating'];

  }
}