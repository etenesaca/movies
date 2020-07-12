import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.65,
        itemHeight: _screenSize.height * 0.45,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          Movie movie = movies[index];
          return Stack(
            children: <Widget>[_buildPoster(movie), _buildDetails(movie)],
          );
        },
      ),
    );
  }

  Widget _buildPoster(Movie movie) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage(
          placeholder: AssetImage('assets/img/no-image.jpg'),
          image: movie.getPosterImg(),
          fit: BoxFit.cover,
        ));
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
                fontFamily: 'Quicksand'),
          ),
          Text(
            'Votos ${movie.voteCount}',
            style: TextStyle(
                color: Colors.white, fontSize: 9.0, fontFamily: 'Quicksand'),
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
                fontFamily: 'Quicksand'),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[_buildDescTitle(movie), _buildVotesStart(movie)],
          ),
        ],
      ),
    );
  }
}
