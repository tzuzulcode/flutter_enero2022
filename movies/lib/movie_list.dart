import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';
import 'package:movies/movie_detail.dart';


class MovieList extends StatefulWidget {
  const MovieList({ Key? key }) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  late HttpHelper helper;
  late List movies;
  late int itemCount;

  @override
  void initState() {
    helper = HttpHelper();
    itemCount = 0;
    movies = [];
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies App"),
        actions: [
          IconButton(onPressed: (){
            //TODO: Añadir funcionalidad de búsqueda con la API
          }, icon: Icon(Icons.search))
        ],
      ),
      body:ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context,int position){
          return Card(
            color: Colors.white,
            elevation:2.0,
            child: ListTile(
              title: Text(movies[position].title),
              subtitle: Text("Released: "+ movies[position].date+" Rating: "+movies[position].rating.toString()),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(movies[position].img)
              ),
              onTap: (){
                MaterialPageRoute route = MaterialPageRoute(builder: (_)=>MovieDetail(null, movies[position]));
                Navigator.push(context, route);
              },
            ),
          );
        })
    );
  }


  Future initialize() async{
    movies = await helper.getMovies();
    setState(() {
      movies = movies;
      itemCount = movies.length;
    });
  }
}