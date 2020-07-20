import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/src/bloc/movie_section_bloc.dart';
import 'package:movies/src/models/gender_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';
import 'package:movies/src/widgets/page_view_section_widget.dart';

class HomePage extends StatefulWidget {
  List<MovieGenre> movieGenres = [];
  HomePage({@required this.movieGenres});

  @override
  _HomePageState createState() => _HomePageState(movieGenres: movieGenres);
}

class _HomePageState extends State<HomePage> {
  Size _screenSize;
  MoviePopularBloc pupularBloc;
  MovieTopRatedBloc topRatedBloc;
  //MovieUpcomingBloc upcomingBloc;

  final moviesProvider = MovieProvider();
  final List<MovieGenre> movieGenres;
  _HomePageState({@required this.movieGenres});

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;

    List<Widget> sections = [
      _buildNowPlayingSection(context),
      FadeInUp(
        duration: Duration(milliseconds: 600),
        child: _buildPopulars(context),
      ),
      FadeInUp(
        duration: Duration(milliseconds: 600),
        child: _buildTopRated(context),
      ),
      /* 
      FadeInUp(
        duration: Duration(milliseconds: 600),
        child: _buildUpcoming(context),
      ),
      */
    ];
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(sections),
        ),
      ],
    );
  }

  Widget _buildNowPlayingSection(BuildContext context) {
    final _cardHeight = _screenSize.height * 0.50;

    final res = FutureBuilder(
        future: moviesProvider.getMoviesNowPlaying(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingData('Q-Loading.gif');
          }
          return Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: CardSwiper(
                  movies: snapshot.data, args: {'movieGenres': movieGenres}));
        });
    return Container(
      height: _cardHeight,
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: res,
    );
  }

  Widget _buildPopulars(BuildContext context) {
    MoviePopularBloc pupularBloc = MoviePopularBloc();
    final res = PageViewSection(
      titleSection: 'Populares',
      moviesStream: pupularBloc.moviesStream,
      sinkNextPage: pupularBloc.getNextPage,
      args: {'movieGenres': movieGenres},
    );
    return res;
  }

  Widget _buildTopRated(BuildContext context) {
    topRatedBloc = MovieTopRatedBloc();
    final res = PageViewSection(
      titleSection: 'Mejor calificadas',
      moviesStream: topRatedBloc.moviesStream,
      sinkNextPage: topRatedBloc.getNextPage,
      args: {'movieGenres': movieGenres},
    );
    return res;
  }

  /*
  Widget _buildUpcoming(BuildContext context) {
    upcomingBloc = MovieUpcomingBloc();
    final res = PageViewSection(
      titleSection: 'Próximamente',
      moviesStream: upcomingBloc.moviesStream,
      sinkNextPage: upcomingBloc.getNextPage,
      args: {'movieGenres': allMovieGenres},
    );
    return res;
  }
   */

  @override
  void dispose() {
    this.pupularBloc?.dispose();
    this.topRatedBloc?.dispose();
    //this.upcomingBloc?.dispose();
    super.dispose();
  }
}
