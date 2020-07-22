import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/gender_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/global_provider.dart';
import 'package:movies/src/providers/movie_api.dart';
import 'package:movies/src/widgets/actors_widget.dart';
import 'package:movies/src/widgets/card_swiper_backdrops_widget.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';
//import 'package:movies/src/widgets/chip_widget.dart';
import 'package:provider/provider.dart';
import 'package:movies/src/widgets/slivers/sliver_movie_poster_widget.dart';

class MovieDetailPage extends StatelessWidget {
  final movieProvider = MovieProvider();
  Size _screenSize;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final Movie movie = args['movie'];

    _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Extras().getBackgroundApp(),
          CustomScrollView(
            //shrinkWrap: true,
            slivers: <Widget>[
              _buildSliverPoster(movie),
              //_buildPosterContent(movie),
              SliverList(
                  delegate: SliverChildListDelegate([
                //_buildPosterMovie(context, movie),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildSectionRating(context, movie),
                      _buildSectionGenres(context, movie,
                          context.watch<GlobalProvider>().allMovieGenres),
                      _buildSectionDescription(context, movie),
                      _buildSectionDatesVotes(context, movie),
                      _buildSectionImages(context, movie),
                      _buildSectionCast(context, movie),
                    ],
                  ),
                )
              ])),
              //_buildSectionCast(context, movie),
            ],
          )
        ],
      ),
    );
  }

  _buildSliverPoster(Movie movie) {
    return SliverPersistentHeader(
      delegate: SliverMoviePoster(expandedHeight: 250, movie: movie),
      pinned: true,
    );
  }

  Widget _geTitleSection(String text) {
    final titleSection = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.white);
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(text, style: titleSection));
  }

  _buildSectionRating(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _geTitleSection('Valoración ${movie.voteAverage}'),
          SizedBox(height: 3),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: Extras().buildstarts(movie.voteAverage, 10)),
        ],
      ),
    );
  }

  Widget _buildBoxGender(MovieGenre genre) {
    return Extras().buildBoxTag(genre.name, Colors.redAccent);
  }

  _buildSectionGenres(
      BuildContext context, Movie movie, List<MovieGenre> movieGenres) {
    movieGenres.where((MovieGenre x) => movie.genreIds.toSet().contains(x.id));

    final List<MovieGenre> genres = [];
    movieGenres.forEach((x) {
      if (movie.genreIds.toSet().contains(x.id.toInt())) genres.add(x);
    });
    final boxes = genres
        .map((e) => ZoomIn(
            duration: Duration(milliseconds: 300), child: _buildBoxGender(e)))
        .toList();
    //final boxes = genres.map((e) => ChipTag(color: Colors.redAccent, label: e.name)).toList();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _geTitleSection('Géneros'),
          SizedBox(height: 3),
          Wrap(spacing: 6.0, runSpacing: 6.0, children: boxes),
        ],
      ),
    );
  }

  _buildSectionDescription(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _geTitleSection('Sinopsis'),
          SizedBox(height: 5),
          Text(
            movie.overview,
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.white70),
          )
        ],
      ),
    );
  }

  _buildSectionDatesVotes(BuildContext context, Movie movie) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _geTitleSection('Fecha de estreno'),
                Text(
                  movie.releaseDate,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.w700),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                _geTitleSection('Votos'),
                Text(
                  '${movie.voteCount}',
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.w700),
                )
              ],
            )
          ],
        ));
  }

  _buildSectionImages(BuildContext context, Movie movie) {
    final images_cards = FutureBuilder(
        future: MovieProvider().getMovieImagesList(movie.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return SwiperBackdrops(images: snapshot.data);
          } else {
            return LoadingData();
          }
        });
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18),
      child: Container(
      height: 150,
      child: images_cards,
    ),
    );
  }

  _buildSectionCast(BuildContext context, Movie movie) {
    final actorItems = FutureBuilder(
        future: movieProvider.getMovieCast(movie.id),
        builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingData();
          }
          return ActorWidget(cast: snapshot.data);
        });
    final res = Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _geTitleSection('Actores'),
          SizedBox(height: 10),
          actorItems
        ],
      ),
    );
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Text('Actores',
              style: TextStyle(
                  color: Colors.white10,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RussoOne')),
        ),
        res
      ],
    );
  }
}
