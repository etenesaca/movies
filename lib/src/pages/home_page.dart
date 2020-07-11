import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'En Cines',
          style:
              TextStyle(fontFamily: 'RussoOne', fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.pinkAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('Buscando');
              }),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _buildBackground(context),
          Column(
            children: <Widget>[
              _buildNowPlayingSection(context),
              _buildPopularSection(context),
            ],
          )
        ],
      ),
    );
  }

  final moviesProvides = MovieProvider();
  Widget _buildNowPlayingSection(BuildContext context) {
    return FutureBuilder(
        future: moviesProvides.getMoviesNowPlaying(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            snapshot.data.forEach((x) {
              print(x.title);
            });
            return Container();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildPopularSection(BuildContext context) {
    return Container();
  }

  _buildBackground(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(.0, 0.5),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Colors.pinkAccent,
            Color.fromRGBO(168, 0, 223, 1.0),
            Color.fromRGBO(112, 0, 223, 1.0),
          ])),
    );
  }
}
