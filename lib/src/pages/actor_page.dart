import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/providers/movie_api.dart';
import 'package:movies/src/widgets/card_swiper_backdrops_widget.dart';
import 'package:movies/src/widgets/chip_widget.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';

class ActorPage extends StatelessWidget {
  MovieProvider movieApi = MovieProvider();
  Extras extras = Extras();

  @override
  Widget build(BuildContext context) {
    Actor actor = ModalRoute.of(context).settings.arguments;
    Color mainColor = extras.mainColor;
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
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
          fontFamily: 'Cinzel');
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

    Widget poster = Container(
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
    );

    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        children: <Widget>[poster, _buildInfo(actor)],
      ),
    );
  }

  Widget _buildInfo(Actor actor) {
    print('${actor.id} - ${actor.name}');
    return FutureBuilder(
      future: movieApi.getActorDetail(actor.id),
      builder: (BuildContext context, AsyncSnapshot<Actor> snapshot) {
        if (!snapshot.hasData) {
          return LoadingData();
        }
        actor = snapshot.data;
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildSec1(actor),
                (actor.biography == null)
                    ? _buildBiography(actor)
                    : SizedBox(
                        height: 20,
                      ),
                _buildBith(actor),
                _buildSectionImages(context, actor),
              ],
            ));
      },
    );
  }

  Widget _buildSec1(Actor actor) {
    Widget popularity = Container(
      child: Row(
        children: <Widget>[
          Icon(Icons.stars, color: Colors.orange, size: 15),
          SizedBox(
            width: 3,
          ),
          Text(
            '${actor.popularity}',
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ZoomIn(
            delay: Duration(microseconds: 100),
            child: extras.buildBoxTag(actor.knownForDepartment, Colors.teal),
          ),
          SizedBox(
            width: 20,
          ),
          ZoomIn(
            delay: Duration(microseconds: 100),
            child: popularity,
          )
        ],
      ),
    );
  }

  Widget _geTitleSection(String text) {
    final titleSection = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.white);
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(text, style: titleSection));
  }

  Widget _buildBiography(Actor actor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: <Widget>[
          Text(
            actor.biography,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  _buildBith(Actor actor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _geTitleSection('Fecha de nacimiento'),
          SizedBox(height: 5),
          Text(
            '${actor.birthday} - ${actor.placeOfBirth}',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.white70),
          ),
          (actor.deathday != null)
              ? Text(
                  'Muerte ${actor.deathday}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                )
              : Container()
        ],
      ),
    );
  }

  _buildSectionImages(BuildContext context, Actor actor) {
    final images_cards = FutureBuilder(
        future: MovieProvider().getActorImagesList(actor.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return SwiperBackdrops(images: snapshot.data);
          } else {
            return LoadingData();
          }
        });
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: images_cards,
    );
  }
}
