import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';

class PageViewActor extends StatelessWidget {
  final Future<List<Actor>> futureActors;
  Extras extras = Extras();
  Size _screenSize;
  PageController _pageController;

  PageViewActor({@required this.futureActors});

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _pageController = PageController(initialPage: 1, viewportFraction: 0.275);
    return _buildSection(context);
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
            height: _screenSize.height * 0.20,
            child: PageView.builder(
              pageSnapping: false,
              controller: _pageController,
              itemCount: actors.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildActorItem(context, actors[index]),
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

  Widget _buildActorItem(BuildContext context, Actor actor) {
    List colorsMale = [Colors.blueGrey];
    List colorsFemale = [Colors.blueGrey];
    Color avatarColor = (actor.gender == 0)
        ? colorsFemale[Random().nextInt(colorsFemale.length)]
        : colorsMale[Random().nextInt(colorsMale.length)];
    final actorPhoto =
        actor.profilePath != null ? actor.getPhotoImgSmall() : null;
    Widget avatar = extras.buildAvatar(avatarColor, actor.name, actorPhoto, 40);
    actor.idHero = 'BA_${actor.idHero}';
    avatar = GestureDetector(
      child: Hero(tag: actor.idHero, child: avatar),
      onTap: () {
        //Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: DetailScreen()));
        Navigator.pushNamed(context, 'actor', arguments: actor);
      },
    );
    avatar = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          avatar,
          SizedBox(height: 5),
          Container(
            width: 70,
            child: Text(
              actor.name,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
              overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    );
    avatar = FadeIn(child: avatar, duration: Duration(milliseconds: 600));
    return avatar;
  }
}
