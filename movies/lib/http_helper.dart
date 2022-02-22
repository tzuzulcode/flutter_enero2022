import 'dart:convert';
import 'dart:io';

//Instalamos http: flutter pub add http
import 'package:http/http.dart' as http;
import 'package:movies/movie.dart';


class HttpHelper{
  final Uri baseUrl = Uri.parse("https://backendtzuzulcode.wl.r.appspot.com/movies");

  Future<List> getMovies() async{
    http.Response result = await http.get(baseUrl);

    if(result.statusCode == HttpStatus.ok){
      final moviesMap = jsonDecode(result.body);
      List movies = moviesMap.map((movie)=>Movie.fromJSON(movie)).toList();
      return movies;
    }
    
    return [];
  }
}