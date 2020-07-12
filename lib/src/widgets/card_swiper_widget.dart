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
          return ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: movies[index].getPosterImg(),
                fit: BoxFit.cover,
              ));
        },
      ),
    );
  }
}

class WWCardSwiper extends StatelessWidget {
  final List<Movie> movies;

  WWCardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.65,
        itemHeight: _screenSize.height * 0.45,
        itemCount: movies.length,
        itemBuilder: (ctx, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network('http://via.placeholder.com/350x150',
                fit: BoxFit.fill),
          );
        },
      ),
    );
  }
}
