import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/gender_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';
import 'package:movies/src/widgets/actors_widget.dart';
import 'package:movies/src/widgets/card_swiper_backdrops_widget.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';
//import 'package:movies/src/widgets/chip_widget.dart';
import 'package:movies/src/widgets/sliver_movie_poster_widget.dart';

class MovieDetailPage extends StatelessWidget {
  final titleSection = TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0);
  final movieProvider = MovieProvider();
  Size _screenSize;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final Movie movie = args['movie'];
    final List<MovieGenre> movieGenres = args['movieGenres'];

    _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
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
                  _buildSectionGenres(context, movie, movieGenres),
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
          Text('Valoración ${movie.voteAverage}', style: titleSection),
          SizedBox(height: 3),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: Extras().buildstarts(movie.voteAverage, 10)),
        ],
      ),
    );
  }

  Widget _buildBoxGender(MovieGenre genre) {
    final txtStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.white);
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 13),
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(30.0),
          color: Colors.redAccent),
      child: Text(genre.name, style: txtStyle),
    );
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
          Text('Géneros', style: titleSection),
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
          Text('Sinopsis', style: titleSection),
          SizedBox(height: 5),
          Text(
            movie.overview,
            textAlign: TextAlign.justify,
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
                Text('Fecha de estreno', style: titleSection),
                SizedBox(height: 5),
                Text(
                  movie.releaseDate,
                  textAlign: TextAlign.justify,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('Votos', style: titleSection),
                SizedBox(height: 5),
                Text(
                  '${movie.voteCount}',
                )
              ],
            )
          ],
        ));
  }

  _buildSectionImages(BuildContext context, Movie movie) {
    final images_cards = FutureBuilder(
        future: MovieProvider().getImagesList(movie.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return SwiperBackdrops(images: snapshot.data);
          } else {
            return LoadingData();
          }
        });
    final res = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Imagenes', style: titleSection),
        SizedBox(height: 5),
        images_cards
      ],
    );
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: images_cards,
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Actores', style: titleSection),
          SizedBox(height: 10),
          actorItems
        ],
      ),
    );
  }
}
