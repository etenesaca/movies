import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class PageViewPopulars extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPageCallBack;

  PageViewPopulars({@required this.movies, @required this.nextPageCallBack});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _pageController =
        PageController(initialPage: 1, viewportFraction: 0.34);

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPageCallBack();
      }
    });

    return Container(
      height: _screenSize.height * 0.28,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildCard(context, movies[index]),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Movie movie) {
    final poster = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: FadeInImage(
        placeholder: AssetImage('assets/img/no-image.jpg'),
        image: movie.getPosterImg(),
        height: 185.0,
        fit: BoxFit.cover,
      ),
    );

    // Starts
    Widget _buildStarIcon(IconData icon) =>
        Icon(icon, color: Colors.yellow[900], size: 12);
    List<Widget> starts = [];
    int avg = movie.voteAverage.toInt();
    bool halfStart = ((movie.voteAverage - avg) * 100) > 10;
    for (var i = 0; i < avg; i++) {
      starts.add(_buildStarIcon(Icons.star));
    }
    if (halfStart) {
      avg++;
      starts.add(_buildStarIcon(Icons.star_half));
    }
    ;
    for (var i = 0; i < (10 - avg); i++) {
      starts.add(_buildStarIcon(Icons.star_border));
    }

    String movie_title = movie.title.length > 28
        ? '${movie.title.substring(0, 28)}...'
        : movie.title;
    final details = Container(
      padding: EdgeInsets.only(left: 11, right: 10, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: starts),
          SizedBox(height: 3.0),
          Text(movie_title,
              overflow: TextOverflow.fade,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
    final res = Container(
      child: Column(
        children: <Widget>[poster, details],
      ),
    );
    return res;
  }
}
