import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/search_delegate.dart/search_movies_delegate.dart';
import 'package:movies/src/bloc/movie_popular_bloc.dart';
import 'package:movies/src/models/gender_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';
import 'package:movies/src/widgets/page_view_section_widget.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = MovieProvider();
  final pupularBloc = MoviePopularBloc();

  List<MovieGenre> allMovieGenres = [];
  Size _screenSize;

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    // Llamar a la primera página del las peliculas populares
    pupularBloc.getNextPage();

    moviesProvider.getGenreList().then((x) {
      allMovieGenres = x;
      print('${allMovieGenres.length} Movie Genderes Loaded');
    });

    List<Widget> sections = [
      _buildNowPlayingSection(context),
      FadeInUp(
        duration: Duration(milliseconds: 600),
        child: _buildPopularSection(context),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'En Cines',
          style:
              TextStyle(fontFamily: 'RussoOne', fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromRGBO(24, 33, 46, 1.0),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: MovieSearch(movieGenres: allMovieGenres));
              }),
        ],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            _buildBackground(context),
            CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(sections),
                ),
              ],
            )
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
            Color.fromRGBO(24, 33, 46, 1.0),
            Color.fromRGBO(24, 33, 46, 1.0),
            Color.fromRGBO(37, 51, 72, 1.0),
            Color.fromRGBO(57, 79, 111, 1.0),
          ])),
    );
  }

  Widget _buildNowPlayingSection(BuildContext context) {
    final _cardHeight = _screenSize.height * 0.55;

    final res = FutureBuilder(
        future: moviesProvider.getMoviesNowPlaying(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingData('Q-Loading.gif');
          }
          return Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: CardSwiper(
                  movies: snapshot.data,
                  args: {'movieGenres': allMovieGenres}));
        });
    return Container(
      height: _cardHeight,
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: res,
    );
  }

  Widget _buildPopularSection(BuildContext context) {
    final res = PageViewSection(
      bloc: pupularBloc,      
      args: {'movieGenres': allMovieGenres},
    );
    return res;
  }
}
