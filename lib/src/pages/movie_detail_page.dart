import 'dart:ffi';

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
import 'package:movies/src/widgets/page_view_actor_movies_widget.dart';
import 'package:provider/provider.dart';
import 'package:movies/src/widgets/slivers/sliver_movie_poster_widget.dart';

class MovieDetailPage extends StatelessWidget {
  final movieApi = MovieProvider();
  final extras = Extras();
  Size _screenSize;

  EdgeInsets paddingSections =
      EdgeInsets.symmetric(vertical: 0, horizontal: 20);

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
                  //padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setPaddingsection(_buildSectionRating(context, movie)),
                      setPaddingsection(_buildSectionGenres(context, movie,
                          context.watch<GlobalProvider>().allMovieGenres)),
                      setPaddingsection(
                          _buildSectionDescription(context, movie)),
                      setPaddingsection(
                          _buildSectionDatesVotes(context, movie)),
                      _buildSectionGalery(context, movie),
                      setPaddingsection(_buildSectionCast(context, movie)),
                      _buildMovieRelateds(context, movie),
                    ],
                  ),
                )
              ])),
              //_buildSectionCast(context, movie),
            ],
          )
        ],
      ),
      floatingActionButton: ZoomIn(
        duration: Duration(milliseconds: 500),
        child: FloatingActionButton(
            backgroundColor: Colors.teal,
            child: Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.pushNamed(context, 'video_list', arguments: movie);
            }),
      ),
    );
  }

  _buildSliverPoster(Movie movie) {
    return SliverPersistentHeader(
      delegate: SliverMoviePoster(expandedHeight: 250, movie: movie),
      pinned: true,
    );
  }

  _buildSectionRating(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          extras.buildTitleSection('Valoración ${movie.voteAverage}'),
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

    final movieDuration = Row(
      children: <Widget>[
        Icon(Icons.access_time, color: Colors.blueAccent, size: 15),
        SizedBox(
          width: 2,
        ),
        Text('15mins',
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold))
      ],
    );
    return extras.buildSection(
        title: 'Géneros',
        action: movieDuration,
        child: Wrap(spacing: 6.0, runSpacing: 6.0, children: boxes),
        showBackground: false);
  }

  Widget setPaddingsection(Widget child) {
    return Padding(padding: paddingSections, child: child);
  }

  _buildSectionDescription(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          extras.buildTitleSection('Sinopsis'),
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
                extras.buildTitleSection('Fecha de estreno'),
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
                extras.buildTitleSection('Votos'),
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

  _buildSectionGalery(BuildContext context, Movie movie) {
    final images = FutureBuilder(
        future: movieApi.getMovieImagesList(movie.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return SwiperBackdrops(images: snapshot.data);
          } else {
            return LoadingData();
          }
        });
    final res = Container(
      height: 150,
      child: images,
    );
    final showAllImages = Text(
      'Ver todo',
      style: TextStyle(color: Colors.blueAccent, fontSize: 12),
    );
    return extras.buildSection(
        title: 'Galeria',
        child: res,
        action: showAllImages,
        paddingHeader: paddingSections);
  }

  _buildSectionCast(BuildContext context, Movie movie) {
    final actorItems = FutureBuilder(
        future: movieApi.getMovieCast(movie.id),
        builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingData();
          }
          return ActorWidget(cast: snapshot.data);
        });
    return extras.buildSection(title: 'Actores', child: actorItems);
  }

  Widget _buildMovieRelateds(BuildContext context, Movie movie) {
    final res =
        PageViewMovieSection(futureMovies: movieApi.getMovieRelateds(movie.id));
    return extras.buildSection(
        title: 'Sugeridas',
        child: res,
        textBackground: 'movies',
        paddingHeader: paddingSections);
  }
}
