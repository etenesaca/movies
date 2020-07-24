import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';

class PageViewMovieSection extends StatelessWidget {
  final Future<List<Movie>> futureMovies;
  Size _screenSize;
  PageController _pageController;

  PageViewMovieSection({@required this.futureMovies});

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _pageController = PageController(initialPage: 1, viewportFraction: 0.375);
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
        });
      },
      child: ZoomIn(
        delay: Duration(microseconds: 100),
        child: res,
      ),
    );
  }

  Widget _getData(BuildContext context) {
    return FutureBuilder(
        future: futureMovies,
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
    return Padding(
      padding: EdgeInsets.only(bottom: 1.0, left: 3, right: 3),
      child: Container(
          width: double.infinity,
          decoration: boxStyle,
          child: _getData(context)),
    );
  }
}
