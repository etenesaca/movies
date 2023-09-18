import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/generated/l10n.dart';
import 'package:movies/src/bloc/movie_section_bloc.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/apis/the_movie_db_api.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';
import 'package:movies/src/widgets/page_view_section_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size _screenSize;
  MoviePopularBloc pupularBloc;
  MovieTopRatedBloc topRatedBloc;
  //MovieUpcomingBloc upcomingBloc;

  final moviesProvider = MovieProvider();

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    final title = Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(S.of(context)!.nowPlaying,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 23,
                    fontFamily: 'RussoOne'))
          ],
        ));

    List<Widget> sections = [
      title,
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

    return SafeArea(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(sections),
        ),
      ],
    ));
  }

  Widget _buildNowPlayingSection(BuildContext context) {
    final _cardHeight = _screenSize.height * 0.50;

    final res = FutureBuilder(
        future: moviesProvider.getMoviesNowPlaying(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingData();
          }
          return Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: CardSwiper(movies: snapshot.data, args: {}));
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
      args: {},
    );
    return res;
  }

  Widget _buildTopRated(BuildContext context) {
    topRatedBloc = MovieTopRatedBloc();
    final res = PageViewSection(
      titleSection: 'Mejor calificadas',
      moviesStream: topRatedBloc.moviesStream,
      sinkNextPage: topRatedBloc.getNextPage,
      args: {},
    );
    return res;
  }

  @override
  void dispose() {
    this.pupularBloc?.dispose();
    this.topRatedBloc?.dispose();
    //this.upcomingBloc?.dispose();
    super.dispose();
  }
}
