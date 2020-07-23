import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/image_model.dart';

class MoviePosterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

    double imageHeight = _screenSize.height * 0.6;
    Backdrop image = ModalRoute.of(context).settings.arguments;

    Widget buttonDownload = FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.cloud_download),
        onPressed: () {});
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildAppBar(image, imageHeight),
          SliverList(delegate: SliverChildListDelegate([]))
        ],
      ),
      floatingActionButton: ZoomIn(
        child: buttonDownload,
        duration: Duration(milliseconds: 500),
      ),
      /* 
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.image),
              onPressed: () {}),
          SizedBox(width: 5),
          ,
      */
    );
  }

  Widget _buildAppBar(Backdrop image, double height) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Extras().mainColor,
      expandedHeight: height,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: FadeInImage(
          image: image.getImgLarge(),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 100),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
