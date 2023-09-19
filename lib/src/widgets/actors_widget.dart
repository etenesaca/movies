import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class ActorWidget extends StatelessWidget {
  Extras extras = Extras();
  final List<Actor>? cast;
  final Movie? movie;

  ActorWidget({this.cast, this.movie});

  @override
  Widget build(BuildContext context) {
    List<Actor> filteredCast = [];
    for (var i = 0; i < min(15, cast!.length); i++) {
      filteredCast.add(cast![i]);
    }
    final items = filteredCast.map((e) => _buildActorItem(context, e)).toList();
    return Wrap(
        alignment: WrapAlignment.center,
        spacing: 7.0,
        runSpacing: 6.0,
        children: items);
  }

  Widget _buildActorItem(BuildContext context, Actor actor) {
    List colorsMale = [Colors.blueGrey];
    List colorsFemale = [Colors.blueGrey];
    Color avatarColor = (actor.gender == 0)
        ? colorsFemale[Random().nextInt(colorsFemale.length)]
        : colorsMale[Random().nextInt(colorsMale.length)];
    final actorPhoto =
        actor.profilePath != null ? actor.getPhotoImgSmall() : null;
    Widget avatar =
        extras.buildAvatar(avatarColor, actor.name!, actorPhoto, 29);
    actor.idHero = '${actor.idHero}_${movie!.idHero}';
    avatar = GestureDetector(
      child: Hero(tag: actor.idHero!, child: avatar),
      onTap: () {
        //Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: DetailScreen()));
        Navigator.pushNamed(context, 'actor', arguments: actor);
      },
    );
    avatar = ZoomIn(child: avatar, duration: Duration(milliseconds: 800));
    return Container(
      child: Column(
        children: <Widget>[
          avatar,
          Text(
            actor.name!,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
            overflow: TextOverflow.clip,
          ),
          Text(
            actor.character!,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                color: Colors.orangeAccent),
          )
        ],
      ),
    );
  }
}
