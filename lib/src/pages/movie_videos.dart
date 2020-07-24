import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/models/video_model.dart';
import 'package:movies/src/providers/movie_api.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';

class VideoListPage extends StatelessWidget {
  Extras extras = Extras();
  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
        backgroundColor: extras.mainColor,
      ),
      body: Stack(
        children: <Widget>[
          getBackground(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[getVideoList(movie)],
            ),
          )
        ],
      ),
    );
  }

  getBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: extras.mainColor),
    );
  }

  Widget getVideoList(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: FutureBuilder(
          future: MovieProvider().getVideos(movie.id),
          builder: (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
            if (!snapshot.hasData) {
              return LoadingData();
            }
            return Column(
              children:
                  snapshot.data.map((e) => getVideoCard(e, movie)).toList(),
            );
          }),
    );
  }

  Widget getVideoCard(Video video, Movie movie) {
    final styleShadow = BoxShadow(
      color: Colors.black.withOpacity(0.9),
      spreadRadius: 1,
      blurRadius: 15,
      offset: Offset(3, 3), // changes position of shadow
    );

    Widget actorPhoto = CircleAvatar(
      radius: 17,
      backgroundImage: movie.getPosterSmallImg(),
    );

    Widget avatar = CircleAvatar(
      radius: 19,
      backgroundColor: Colors.blueGrey,
      child: actorPhoto,
    );
    avatar = Container(
      decoration: BoxDecoration(
        boxShadow: [styleShadow],
        shape: BoxShape.circle,
      ),
      child: avatar,
    );
    return ZoomIn(
      duration: Duration(milliseconds: 500),
      child: Card(
        color: Color.fromRGBO(57, 79, 111, 1.0),
        child: Column(
          //VideoScreen(id: video.key),
          children: <Widget>[
            ListTile(
              leading: avatar,
              title: Text(video.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
              subtitle: Text(video.type,
                  style: TextStyle(color: Colors.white60, fontSize: 11)),
            )
          ],
        ),
      ),
    );
  }
}
