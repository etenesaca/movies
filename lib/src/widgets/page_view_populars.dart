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
        PageController(initialPage: 1, viewportFraction: 0.31);

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
        height: 180.0,
        fit: BoxFit.cover,
      ),
    );

    // Starts
    Widget _buildStarIcon(IconData icon) =>
        Icon(icon, color: Colors.yellow[900], size: 13);
    final double avg = movie.voteAverage / 2;
    List<Widget> starts = [];
    for (var i = 0; i < avg.toInt(); i++) {
      starts.add(_buildStarIcon(Icons.star));
    }
    if (avg - avg.toInt() > 0) starts.add(_buildStarIcon(Icons.star_half));

    final details = Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(movie.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              SizedBox(height: 3.0),
          Row(children: starts),
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
