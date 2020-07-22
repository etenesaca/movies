import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/image_model.dart';

class MoviePosterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Backdrop image = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildAppBar(image),
          SliverList(delegate: SliverChildListDelegate([]))
        ],
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
          FloatingActionButton(
              backgroundColor: Colors.teal,
              child: Icon(
                Icons.cloud_download,
              ),
              onPressed: () {})
        ],
      ),
      */
    );
  }

  Widget _buildAppBar(Backdrop image) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Extras().mainColor,
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      title: Text(
        'pelicula.title',
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
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
