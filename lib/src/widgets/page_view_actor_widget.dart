import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';

class PageViewActor extends StatelessWidget {
  final Future<List<Actor>> futureActors;
  Size _screenSize;
  PageController _pageController;

  PageViewActor({@required this.futureActors});

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _pageController = PageController(initialPage: 1, viewportFraction: 0.375);
    return _buildSection(context);
  }

  Widget _buildCard(BuildContext context, Actor actor) {
    final posterCropped = Extras()
        .buildPosterImg(actor.getPhotoImgUrl(), 175.0, 110.0, corners: 5);
    String actor_title = actor.name.length > 28
        ? '${actor.name.substring(0, 28)}...'
        : actor.name;
    final textStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white70);
    final details = Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /*
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Extras().buildstarts(actor.popularity / 2, 5)),
          SizedBox(height: 2.0),
           */
          Text(actor_title, overflow: TextOverflow.fade, style: textStyle),
        ],
      ),
    );
    final res = Container(
      child: Column(
        children: <Widget>[
          Hero(tag: actor.idHero, child: posterCropped),
          details
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'actor', arguments: actor);
      },
      child: ZoomIn(
        delay: Duration(microseconds: 100),
        child: res,
      ),
    );
  }

  Widget _getData(BuildContext context) {
    return FutureBuilder(
        future: futureActors,
        builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top: 25, bottom: 25),
              child: LoadingData(),
            );
          }
          final actors = snapshot.data;
          if (actors.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.people, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    'No hay actores.',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
            );
          }
          return Container(
            height: _screenSize.height * 0.313,
            child: PageView.builder(
              pageSnapping: false,
              controller: _pageController,
              itemCount: actors.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildCard(context, actors[index]),
            ),
          );
        });
  }

  Widget _buildSection(BuildContext context) {
    final radiusCorners = Radius.circular(25.0);
    final boxStyle = BoxDecoration(
        //color: Colors.white,
        borderRadius:
            BorderRadius.only(topRight: radiusCorners, topLeft: radiusCorners));
    return Padding(
      padding: EdgeInsets.only(bottom: 1.0, left: 3, right: 3),
      child: Container(
          width: double.infinity,
          decoration: boxStyle,
          child: _getData(context)),
    );
  }
}
