import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  final Map<String, dynamic> args;

  Size _screenSize;
  double _cardCorners = 10.0;
  double _cardWidth;
  double _cardHeight;

  CardSwiper({@required this.movies, @required this.args});

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _cardWidth = _screenSize.width * 0.65;
    _cardHeight = _screenSize.height * 0.45;
    return Container(
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _cardWidth,
        itemHeight: _cardHeight,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          Movie movie = movies[index];
          return Stack(
            children: <Widget>[
              _buildPoster(context, movie),
              _buildDetails(movie)
            ],
          );
        },
      ),
    );
  }

  Widget _buildPoster(BuildContext context, Movie movie) {
    final posterCropped = Extras().buildPosterImg(
        movie.getPosterImgUrl(), double.infinity, double.infinity,
        corners: _cardCorners);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'movie_detail',
            arguments: {'movie': movie, 'movieGenres': args['movieGenres']});
      },
      child: Hero(tag: movie.idHero, child: posterCropped),
    );
  }

  Widget _buildDescTitle(movie) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          Text(
            'Votos ${movie.voteCount}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVotesStart(movie) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.black54,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: <Widget>[
          Text(
            '${movie.voteAverage}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 2.0),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 14.0,
          )
        ],
      ),
    );
  }

  Widget _buildDetails(Movie movie) {
    final background = BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(_cardCorners),
            bottomRight: Radius.circular(_cardCorners)),
        gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.1),
            end: FractionalOffset(0.0, 0.6),
            colors: [
              Colors.transparent,
              Colors.black54,
              Colors.black87,
            ]));
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
            decoration: background,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 45.0),
                _buildDescTitle(movie),
                _buildVotesStart(movie)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
