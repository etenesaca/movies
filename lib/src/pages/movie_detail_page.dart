import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/widgets/sliver_movie_poster_widget.dart';

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverPoster(movie),
          //_buildPosterContent(movie),
          SliverList(
              delegate: SliverChildListDelegate([
            //_buildPosterMovie(context, movie),
            SizedBox(
              height: 10.0,
            ),
            //_buildPosterMovie(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            //_buildCast(context, pelicula),
          ]))
        ],
      ),
    );
  }

  _buildSliverPoster(Movie movie) {
    return SliverPersistentHeader(
      delegate: SliverMoviePoster(expandedHeight: 250, movie: movie),
      pinned: true,
    );
  }

  _buildDescription(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            movie.overview,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }

  _buildPosterMovie(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.idHero,
            child: ClipRRect(
              child: Image(
                image: movie.getPosterImg(),
                height: 150.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                style: Theme.of(context).textTheme.title,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                movie.originalTitle,
                style: Theme.of(context).textTheme.subhead,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subhead,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
