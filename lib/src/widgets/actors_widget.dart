import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:flutter/material.dart';

class ActorWidget extends StatelessWidget {
  final List<Actor> cast;

  ActorWidget({List<Actor> this.cast});

  @override
  Widget build(BuildContext context) {
    final items = cast.map((e) => _buildActorItem(e)).toList();
    return Wrap(
        alignment: WrapAlignment.center,
        spacing: 6.0,
        runSpacing: 6.0,
        children: items);
  }

  Widget _buildActorItem(Actor actor) {
    final styleShadow = BoxShadow(
      color: Colors.black.withOpacity(0.9),
      spreadRadius: 1,
      blurRadius: 15,
      offset: Offset(3, 3), // changes position of shadow
    );

    List colorsMale = [
      Colors.red,
      Colors.green,
      Colors.blueAccent,
      Colors.teal,
      Colors.brown
    ];
    List colorsFemale = [Colors.pink, Colors.yellow];
    Color avatarColor = (actor.gender == 0)
        ? colorsFemale[Random().nextInt(colorsFemale.length)]
        : colorsMale[Random().nextInt(colorsMale.length)];

    Widget actorPhoto;
    if (actor.profilePath == null) {
      actorPhoto = Center(
          child: Text(
        actor.name.substring(0, 2).toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
    } else {
      actorPhoto = CircleAvatar(
        radius: 27,
        backgroundImage: actor.getPhotoImgSmall(),
      );
    }

    Widget avatar = CircleAvatar(
      radius: 30,
      backgroundColor: avatarColor,
      child: actorPhoto,
    );


    avatar = Container(
      decoration: BoxDecoration(
        boxShadow: [styleShadow],
        shape: BoxShape.circle,
      ),
      child: avatar,
    );

    avatar = ZoomIn(child: avatar, duration: Duration(milliseconds: 800));
    return Container(
      child: Column(
        children: <Widget>[
          avatar,
          Text(
            actor.name,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            overflow: TextOverflow.clip,
          ),
          Text(
            actor.character,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
