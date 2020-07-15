import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class SliverMoviePoster extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Movie movie;

  SliverMoviePoster({@required this.expandedHeight, @required this.movie});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        _buildBackGround(context, movie),
        _buildAppBar(context, movie),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 1.5,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 15,
              child: _buildPoster(movie),
            ),
          ),
        ),
      ],
    );
  }

  _buildPoster(Movie movie) {
    final poster = ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: FadeInImage(
        placeholder: AssetImage('assets/img/no-image.jpg'),
        image: movie.getPosterImg(),
        height: 185.0 - (185.0 * 0.10),
        width: 120.0 - (120.0 * 0.10),
        fit: BoxFit.cover,
      ),
    );
    return Hero(
      tag: movie.idHero,
      child: poster,
    );
  }

  _buildBackGround(BuildContext context, Movie movie) {
    return FadeInImage(
      placeholder: AssetImage('assets/img/loading.gif'),
      image: movie.getBackgroundImg(),
      fit: BoxFit.cover,
    );
  }

  _buildAppBar(BuildContext context, Movie movie) {
    final text = Text(
      movie.title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    );

    return AppBar(
      backgroundColor: Colors.transparent,
      title: Container(
        child: text,
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 15;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
