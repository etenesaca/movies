import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_shadow/flutter_icon_shadow.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/movie_model.dart';

class SliverMoviePoster extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Movie movie;
  Color mainColor = Color.fromRGBO(24, 33, 46, 1);
  double heightPoster = 185.0 - (185.0 * 0.10);
  double widthPoster = 120.0 - (120.0 * 0.10);

  SliverMoviePoster({required this.expandedHeight, required this.movie});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      //overflow: Overflow.visible,
      children: [
        _buildBackGround(context, movie),
        _buildBackGroundOpacity(context),
        _buildAppBar(context, movie),
        //_buildTrailerButton(context, shrinkOffset),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          //left: MediaQuery.of(context).size.width / 1.5,
          left: MediaQuery.of(context).size.width - widthPoster - 15,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: _buildPoster(movie),
          ),
        ),
      ],
    );
  }

  _buildTrailerButton(BuildContext context, double shrinkOffset) {
    return GestureDetector(
      child: Opacity(
        opacity: (1 - shrinkOffset / expandedHeight),
        child: ZoomIn(
          duration: Duration(milliseconds: 700),
          child: Icon(
            Icons.play_circle_outline,
            color: Colors.white,
            size: 60,
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'video_list', arguments: movie);
      },
    );
  }

  _buildPoster(Movie movie) {
    final posterCropped = Extras().buildPosterImg(
        movie.getPosterImgUrl(), heightPoster, widthPoster,
        corners: 5 + (5 * 0.20));
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(1, 7), // changes position of shadow
          ),
        ],
      ),
      child: Hero(tag: movie.idHero!, child: posterCropped),
    );
  }

  _buildBackGround(BuildContext context, Movie movie) {
    return FadeInImage(
      placeholder: AssetImage('assets/img/loading.gif'),
      image: movie.getBackgroundImg(),
      fit: BoxFit.cover,
    );
  }

  _buildBackGroundOpacity(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(.0, 0.5),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Colors.transparent,
            mainColor.withOpacity(0.0),
            mainColor.withOpacity(0.5),
            mainColor.withOpacity(0.9),
            mainColor,
          ])),
    );
  }

  _buildAppBar(BuildContext context, Movie movie) {
    final textShadow = BoxShadow(
      color: Colors.black.withOpacity(0.9),
      spreadRadius: 5,
      blurRadius: 15,
      offset: Offset(3, 3), // changes position of shadow
    );
    final text = Text(
      movie.title!,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
          shadows: [textShadow, textShadow, textShadow]),
    );
    Widget buttonBack = Padding(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
        child: IconShadow(
          Icon(Icons.arrow_back, color: Colors.white, size: 28),
          showShadow: true,
          shadowColor: Colors.black,
        ));
    buttonBack = GestureDetector(
        child: buttonBack,
        onTap: () {
          Navigator.pop(context);
        });
    return SafeArea(
        child: Column(children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[buttonBack, text],
      )
    ]));
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 25;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
