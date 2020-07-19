import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/bloc/movie_popular_bloc.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';

class PageViewSection extends StatefulWidget {
  final MoviePopularBloc bloc;
  final Map<String, dynamic> args;

  PageViewSection({@required this.bloc, @required this.args});

  @override
  _PageViewSectionState createState() => _PageViewSectionState();
}

class _PageViewSectionState extends State<PageViewSection> {
  Size _screenSize;

  PageController _pageController;

  @override
  void dispose() {
    super.dispose();
    widget.bloc.disposeStream();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _pageController = PageController(initialPage: 1, viewportFraction: 0.375);

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        widget.bloc.getNextPage();
      }
    });

    return _buildSection(context);
  }

  Widget _buildCard(BuildContext context, Movie movie) {
    final posterCropped = Extras()
        .buildPosterImg(movie.getPosterImgUrl(), 175.0, 110.0, corners: 5);
    String movie_title = movie.title.length > 28
        ? '${movie.title.substring(0, 28)}...'
        : movie.title;
    final textStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white70);
    final details = Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Extras().buildstarts(movie.voteAverage / 2, 5)),
          SizedBox(height: 2.0),
          Text(movie_title, overflow: TextOverflow.fade, style: textStyle),
        ],
      ),
    );
    final res = Container(
      child: Column(
        children: <Widget>[
          Hero(tag: movie.idHero, child: posterCropped),
          details
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'movie_detail', arguments: {
          'movie': movie,
          'movieGenres': widget.args['movieGenres']
        });
      },
      child: ZoomIn(
        delay: Duration(microseconds: 100),
        child: res,
      ),
    );
  }

  Widget _getStreamData(BuildContext context) {
    return StreamBuilder(
        stream: widget.bloc.popularesStream,
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top: 25, bottom: 25),
              child: LoadingData(),
            );
          }
          final movies = snapshot.data;
          return Container(
            height: _screenSize.height * 0.313,
            child: PageView.builder(
              pageSnapping: false,
              controller: _pageController,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildCard(context, movies[index]),
            ),
          );
        });
  }

  Widget _buildSection(BuildContext context) {
    final radiusCorners = Radius.circular(25.0);
    final boxStyle = BoxDecoration(
        //color: Colors.white,
        borderRadius:
            BorderRadius.only(topRight: radiusCorners, topLeft: radiusCorners));
    Widget headerSection = Row(
      children: <Widget>[
        Text('Más populares',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16))
      ],
    );
    return Padding(
      padding: EdgeInsets.only(bottom: 1.0),
      child: Container(
        width: double.infinity,
        decoration: boxStyle,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 20.0, top: 15.0, bottom: 15.0),
                child: headerSection),
            Padding(
              padding: EdgeInsets.only(left: 3, right: 3),
              child: _getStreamData(context),
            ),
          ],
        ),
      ),
    );
  }
}
