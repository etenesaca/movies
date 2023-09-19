import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class SliverAppBarActor extends StatelessWidget {
  const SliverAppBarActor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget _buildAppBar(Movie pelicula) {
  return SliverAppBar(
    elevation: 2.0,
    backgroundColor: Colors.indigoAccent,
    expandedHeight: 200.0,
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: Text(
        pelicula.title!,
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
      background: FadeInImage(
        image: pelicula.getBackgroundImg(),
        placeholder: AssetImage('assets/img/loading.gif'),
        fadeInDuration: Duration(milliseconds: 100),
        fit: BoxFit.cover,
      ),
    ),
  );
}
