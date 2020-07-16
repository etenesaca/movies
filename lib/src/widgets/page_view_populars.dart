import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/extras.dart';
import 'package:movies/src/models/movie_model.dart';

class PageViewPopulars extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPageCallBack;

  PageViewPopulars({@required this.movies, @required this.nextPageCallBack});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _pageController =
        PageController(initialPage: 1, viewportFraction: 0.375);

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPageCallBack();
      }
    });

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
  }

  Widget buildStart() {}

  Widget _buildCard(BuildContext context, Movie movie) {
    final posterCropped = ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: FadeInImage(
        placeholder: AssetImage('assets/img/no-image.jpg'),
        image: movie.getPosterImg(),
        height: 185.0,
        width: 120.0,
        fit: BoxFit.cover,
      ),
    );

    String movie_title = movie.title.length > 28
        ? '${movie.title.substring(0, 28)}...'
        : movie.title;
    final details = Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Extras().buildstarts(movie.voteAverage / 2, 5)),
          SizedBox(height: 2.0),
          Text(movie_title,
              overflow: TextOverflow.fade,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
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
        Navigator.pushNamed(context, 'movie_detail', arguments: movie);
      },
      child: ZoomIn(
        delay: Duration(microseconds: 100),
        child: res,
      ),
    );
  }
}
