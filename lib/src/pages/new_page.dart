import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/apis/the_movie_db_api.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';
import 'package:movies/src/widgets/page_view_actor_movies_widget.dart';

class NewPage extends StatelessWidget {
  MovieProvider movieApi = MovieProvider();
  Extras extras = Extras();
  Color mainColor;
  Size _screenSize;
  EdgeInsets paddingSections =
      EdgeInsets.symmetric(vertical: 0, horizontal: 20);

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    mainColor = Extras().mainColor;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[buildPosterlastMovie(), _buildMovieUpcoming()],
      ),
    );
  }

  Widget buildPosterlastMovie() {
    return FutureBuilder(
        future: movieApi.getMoviesSection('upcoming', 1),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: LoadingData(),
              ),
            );
          }
          final movies = snapshot.data;
          return _buildPoster(context, movies[Random().nextInt(movies.length)]);
        });
  }

  Widget _buildPoster(BuildContext context, Movie movie) {
    double imageHeight = _screenSize.height * 0.6;
    Widget _imagePoster() {
      Widget res = FadeInImage(
        placeholder: AssetImage('assets/img/loading.gif'),
        image: movie.getPosterImg(),
        fit: BoxFit.cover,
        height: imageHeight,
        width: double.infinity,
      );
      movie.idHero = '${movie.idHero}_latest';
      return Hero(
        tag: movie.idHero,
        child: res,
      );
    }

    Widget _filter() {
      return Container(
        height: imageHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset(0.1, 0.5),
                end: FractionalOffset(0.1, 0.97),
                colors: [
              Colors.transparent,
              mainColor.withOpacity(0.0),
              mainColor.withOpacity(0.3),
              mainColor.withOpacity(0.5),
              mainColor.withOpacity(0.7),
              mainColor.withOpacity(0.8),
              mainColor.withOpacity(0.9),
              mainColor,
            ])),
      );
    }

    Widget _movieName(BuildContext context) {
      final textStyle = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
          fontFamily: 'RussoOne');
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: imageHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              movie.title,
              style: textStyle,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(Icons.add, color: Colors.white),
                    Text(
                      'Mi Lista',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
                SizedBox(width: 25),
                TextButton(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.play_arrow),
                        Text(
                          'Trailer',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'video_list',
                          arguments: movie);
                    }),
                SizedBox(width: 25),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'movie_detail', arguments: {
                      'movie': movie,
                    });
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.info_outline, color: Colors.white),
                      Text(
                        'Información',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget poster = Container(
      child: Center(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                _imagePoster(),
              ],
            ),
            _filter(),
            _movieName(context),
            //appBar,
          ],
        ),
      ),
    );
    return poster;
  }

  Widget _buildMovieUpcoming() {
    final res = PageViewMovieSection(
        futureMovies: movieApi.getMoviesSection('upcoming', 1));
    return extras.buildSection(
        title: 'Próximamente',
        child: res,
        textBackground: 'movies',
        paddingHeader: paddingSections);
  }
}
