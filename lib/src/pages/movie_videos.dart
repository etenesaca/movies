import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/widgets/video_player.dart';

class VideoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[VideoScreen(id: 'e5bklM7YfIo')],
      ),
    );
  }
}
