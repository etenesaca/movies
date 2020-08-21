import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/generated/l10n.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/models/video_model.dart';
import 'package:movies/src/apis/the_movie_db_api.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';
import 'package:movies/src/widgets/video_player.dart';

class VideoListPage extends StatelessWidget {
  Extras extras = Extras();
  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).trailers),
        backgroundColor: extras.mainColor,
      ),
      body: Stack(
        children: <Widget>[getBackground(), getListviewVideo(movie)],
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

  Widget getListviewVideo(Movie movie) {
    return FutureBuilder(
        future: MovieProvider().getVideos(movie.id),
        builder: (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingData();
          }
          //
          final ytVideos = snapshot.data
              .where((e) => e.site.toLowerCase() == 'youtube')
              .toList();
          if (ytVideos.isEmpty) {
            return Center(
              child: _buildNoHasResult(context),
            );
          }
          return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              itemCount: ytVideos.length,
              itemBuilder: (context, index) {
                return getVideoCard(context, ytVideos[index], movie);
              });
        });
  }

  Widget _buildNoHasResult(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            S.of(context).no_has_videos,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            S.of(context).try_search_other_movie,
            style: TextStyle(color: Colors.white60, fontSize: 12),
          )
        ],
      ),
    );
  }

  openVideoViewer(BuildContext context, Video video) {
    Navigator.pushNamed(context, 'play_trailer', arguments: video);
    /*
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Hero(
          tag: 'ytvideo_${video.id}',
          child: AlertDialog(
              contentPadding: EdgeInsets.all(0),
              insetPadding: EdgeInsets.all(5),
              elevation: 15,
              content: VideoScreen(id: video.key, autoPlay: true)),
        );
      },
    );
    */
  }

  Widget buildThumbnail(BuildContext context, Video video) {
    final res = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final boxHeight = constraints.maxWidth * 0.5625;
      final boxWidth = constraints.maxWidth;
      final thumbnait = extras.buildPosterImg(
          'https://img.youtube.com/vi/${video.key}/0.jpg', boxHeight, boxWidth,
          corners: 0, fit: BoxFit.fitWidth);
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          thumbnait,
          Icon(
            Icons.play_circle_outline,
            color: Colors.white,
            size: boxHeight * 0.35,
          )
        ],
      );
    });
    return GestureDetector(
      child: Hero(tag: 'ytvideo_${video.id}', child: res),
      onTap: () {
        openVideoViewer(context, video);
      },
    );
  }

  Widget getVideoCard(BuildContext context, Video video, Movie movie) {
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
          children: <Widget>[
            //VideoScreen(id: video.key),
            buildThumbnail(context, video),
            ListTile(
              trailing: extras.buildBoxTag(video.lang, Colors.white,
                  textColor: Colors.blueAccent),
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
