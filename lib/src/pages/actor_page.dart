import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/actor_model.dart';

class ActorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Actor actor = ModalRoute.of(context).settings.arguments;
    Color mainColor = Extras().mainColor;
    Size _screenSize = MediaQuery.of(context).size;

    double imageHeight = _screenSize.height * 0.6;

    Widget _imagePoster() {
      Widget res = FadeInImage(
        placeholder: AssetImage('assets/img/loading.gif'),
        image: actor.getPhotoImg(),
        fit: BoxFit.cover,
        height: imageHeight,
        width: double.infinity,
      );
      return Hero(
        tag: actor.id,
        child: res,
      );
    }

    Widget _filter() {
      return Container(
        height: imageHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset(0.1, 0.5),
                end: FractionalOffset(0.1, 0.97),
                colors: [
              Colors.transparent,
              mainColor.withOpacity(0.0),
              mainColor.withOpacity(0.3),
              mainColor.withOpacity(0.5),
              mainColor.withOpacity(0.7),
              mainColor.withOpacity(0.8),
              mainColor.withOpacity(0.9),
              mainColor,
            ])),
      );
    }

    Widget _actorName() {
      final textStyle = TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 70),
        height: imageHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              actor.name,
              style: textStyle,
            )
          ],
        ),
      );
    }

    Widget appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
    );

    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        child: Center(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _imagePoster(),
                ],
              ),
              _filter(),
              _actorName(),
              appBar,
            ],
          ),
        ),
      ),
    );
  }
}
