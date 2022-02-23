import 'package:flutter/material.dart';
import 'movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  const MovieDetail(Key? key,this.movie) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Image.network(movie.img),
              ),
              Container(
                child: Text(movie.title),
              )
            ],
          ),
        ),
      ),
    );
  }
}