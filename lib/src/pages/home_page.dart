import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/src/block/movie_popular_bloc.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/page_view_populars.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = MovieProvider();
  final pupularBloc = MoviePopularBloc();

  @override
  Widget build(BuildContext context) {
    // Llamar a la primera página del las peliculas populares
    pupularBloc.getNextPage();

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
          IconButton(icon: Icon(Icons.search), onPressed: _btnSearch),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _buildBackground(context),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildNowPlayingSection(context),
              FadeInUp(
                duration: Duration(milliseconds: 600),
                child: _buildPopularSection(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _btnSearch() {
    print('Buscando');
  }

  Widget _buildNowPlayingSection(BuildContext context) {
    return FutureBuilder(
        future: moviesProvider.getMoviesNowPlaying(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            return Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: CardSwiper(movies: snapshot.data));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildPopularCards(BuildContext context) {
    return StreamBuilder(
        stream: pupularBloc.popularesStream,
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            return PageViewPopulars(
                movies: snapshot.data,
                nextPageCallBack: pupularBloc.getNextPage);
          } else {
            return Padding(
              padding: EdgeInsets.only(top: 25, bottom: 25),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  Widget _buildPopularSection(BuildContext context) {
    final radiusCorners = Radius.circular(25.0);
    final boxStyle = BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.only(topRight: radiusCorners, topLeft: radiusCorners));
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: double.infinity,
        decoration: boxStyle,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 8.0, bottom: 10.0),
              child: Text('Más populares',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.purple[900])),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3, right: 3),
              child: _buildPopularCards(context),
            ),
          ],
        ),
      ),
    );
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
