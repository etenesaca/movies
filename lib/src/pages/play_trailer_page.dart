import 'package:flutter/material.dart';
import 'package:movies/src/models/video_model.dart';
import 'package:movies/src/widgets/video_player.dart';

class PlayTrailerPage extends StatelessWidget {
  const PlayTrailerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Video video = ModalRoute.of(context)!.settings.arguments as Video;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Center(
        child: Hero(
            tag: 'ytvideo_${video.id}',
            child: VideoScreen(id: video.key, autoPlay: true)),
      ),
    );
  }
}
