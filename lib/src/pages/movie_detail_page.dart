import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/generated/l10n.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/gender_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/global_provider.dart';
import 'package:movies/src/apis/the_movie_db_api.dart';
import 'package:movies/src/widgets/actors_widget.dart';
import 'package:movies/src/widgets/card_swiper_backdrops_widget.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';
import 'package:movies/src/widgets/page_view_actor_movies_widget.dart';
import 'package:provider/provider.dart';
import 'package:movies/src/widgets/slivers/sliver_movie_poster_widget.dart';

class MovieDetailPage extends StatelessWidget {
  final movieApi = MovieProvider();
  final extras = Extras();

  EdgeInsets paddingSections =
      EdgeInsets.symmetric(vertical: 1, horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final Movie movie = args['movie'];

    final page = Scaffold(
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
                      setPaddingsection(_buildMovieActions(context, movie)),
                      setPaddingsection(_buildSectionGenres(context, movie,
                          context.watch<GlobalProvider>().allMovieGenres)),
                      setPaddingsection(
                          _buildSectionDescription(context, movie)),
                      setPaddingsection(
                          _buildSectionDatesVotes(context, movie)),
                      _buildSectionGalery(context, movie),
                      setPaddingsection(_buildSectionCast(context, movie)),
                      _buildMovieSimilars(context, movie),
                      _buildMovieRecommendeds(context, movie),
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
    return page;
  }

  _buildMovieActions(BuildContext context, Movie movie) {
    final durationAnimation = Duration(milliseconds: 500);
    final res = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ZoomIn(
          duration: durationAnimation,
          child: Column(
            children: <Widget>[
              Icon(Icons.add, color: Colors.white),
              Text(
                S.of(context).myList,
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
        ),
        SizedBox(width: 25),
        ZoomIn(
          duration: durationAnimation,
          child: RaisedButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.play_arrow),
                  Text(
                    S.of(context).trailer,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'video_list', arguments: movie);
              }),
        ),
        SizedBox(width: 25),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'movie_detail', arguments: {
              'movie': movie,
            });
          },
          child: ZoomIn(
            duration: durationAnimation,
            child: Column(
              children: <Widget>[
                Icon(Icons.thumbs_up_down, color: Colors.white),
                Text(
                  S.of(context).rate,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                )
              ],
            ),
          ),
        ),
      ],
    );
    return res;
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
          extras.buildTitleSection(
              '${S.of(context).rating} ${movie.voteAverage}'),
          SizedBox(height: 3),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: Extras().buildstarts(movie.voteAverage, 10)),
        ],
      ),
    );
  }

  buildMovieRuntime(Movie movie) {
    return FutureBuilder(
        future: movieApi.getMovieDetail(movie.id),
        builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final res = Row(
            children: <Widget>[
              Icon(Icons.access_time, color: Colors.blueAccent, size: 15),
              SizedBox(
                width: 2,
              ),
              Text('${snapshot.data.runtime}min',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold))
            ],
          );
          return ZoomIn(
            duration: Duration(milliseconds: 500),
            child: res,
          );
        });
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

    return extras.buildSection(
        title: S.of(context).genres,
        action: buildMovieRuntime(movie),
        child: Wrap(spacing: 6.0, runSpacing: 6.0, children: boxes),
        showBackground: false);
  }

  Widget setPaddingsection(Widget child) {
    return Padding(padding: paddingSections, child: child);
  }

  _buildSectionDescription(BuildContext context, Movie movie) {
    final textStyle = TextStyle(color: Colors.white70);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          extras.buildTitleSection('Sinopsis'),
          SizedBox(height: 5),
          ExpandableText(movie.overview,
              expandText: S.of(context).show_more,
              collapseText: S.of(context).show_less,
              textAlign: TextAlign.justify,
              linkColor: Colors.redAccent,
              maxLines: 6,
              style: textStyle),
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
                extras.buildTitleSection(S.of(context).release_date),
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
                extras.buildTitleSection(S.of(context).votes),
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
    double heightCard = 150;
    double widthCard = heightCard + heightCard * .40;
    final images = FutureBuilder(
        future: movieApi.getMovieImagesList(movie.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return SwiperBackdrops(
              images: snapshot.data,
              heightCard: heightCard,
              widthCard: widthCard,
            );
          } else {
            return LoadingData();
          }
        });
    final res = Container(
      height: heightCard,
      child: images,
    );
    final showAllImages = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(),
        RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          shape: StadiumBorder(),
          color: Colors.white10,
          child: Row(
            children: <Widget>[
              Icon(
                Icons.photo_library,
                color: Colors.orangeAccent,
                size: 15,
              ),
              SizedBox(width: 5),
              Text(S.of(context).show_all,
                  style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold))
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'galery',
                arguments: movieApi.getMovieImagesList(movie.id));
          },
        )
      ],
    );
    return extras.buildSection(
        title: 'Wallpapers',
        child: res,
        action: showAllImages,
        paddingHeader: EdgeInsets.only(left: 20, right: 5, top: 10));
  }

  _buildSectionCast(BuildContext context, Movie movie) {
    final actorItems = FutureBuilder(
        future: movieApi.getMovieCast(movie.id),
        builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingData();
          }
          return ActorWidget(cast: snapshot.data, movie: movie);
        });
    return extras.buildSection(
        title: S.of(context).principal_actors,
        child: actorItems,
        textBackground: S.of(context).actors.toLowerCase());
  }

  Widget _buildMovieRecommendeds(BuildContext context, Movie movie) {
    final res = PageViewMovieSection(
        futureMovies: movieApi.getMovieRecommendeds(movie.id));
    return extras.buildSection(
        title: S.of(context).suggested, child: res, paddingHeader: paddingSections);
  }

  Widget _buildMovieSimilars(BuildContext context, Movie movie) {
    final res =
        PageViewMovieSection(futureMovies: movieApi.getMovieSimilars(movie.id));
    return extras.buildSection(
        title: S.of(context).similars, child: res, paddingHeader: paddingSections);
  }
}
