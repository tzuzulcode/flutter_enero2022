import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';


class MovieList extends StatefulWidget {
  const MovieList({ Key? key }) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  String result = "";
  late HttpHelper helper;

  @override
  void initState() {
    helper = HttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    helper.getMovies().then((value){
      setState(() {
        result = value;
      });
    })
    .catchError((error){
      print(error.toString());
    });

    return Scaffold(
      appBar: AppBar(title: Text("Movies App"),),
      body:Container(
        child: Text(result),
      )
    );
  }
}