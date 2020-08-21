import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/generated/l10n.dart';
import 'package:movies/src/apis/the_movie_db_api.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';
import 'package:movies/src/widgets/page_view_actor_movies_widget.dart';
import 'package:movies/src/widgets/page_view_actor_widget.dart';

class PopularActorsPage extends StatelessWidget {
  MovieProvider movieApi = MovieProvider();
  Extras extras = Extras();
  Color mainColor;
  Size _screenSize;
  EdgeInsets paddingSections =
      EdgeInsets.symmetric(vertical: 0, horizontal: 20);

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    mainColor = Extras().mainColor;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[buildPosterLastActor(), buildBestActors(context)],
      ),
    );
  }

  Widget buildPosterLastActor() {
    return FutureBuilder(
        future: movieApi.getPopularActors(),
        builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
          if (!snapshot.hasData) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: LoadingData(),
              ),
            );
          }
          final bestActors = snapshot.data;
          return _buildPoster(
              context, bestActors[Random().nextInt(bestActors.length)]);
        });
  }

  Widget _buildPoster(BuildContext context, Actor actor) {
    double imageHeight = _screenSize.height * 0.6;
    Widget _imagePoster() {
      Widget res = FadeInImage(
        placeholder: AssetImage('assets/img/loading.gif'),
        image: actor.getPhotoImg(),
        fit: BoxFit.cover,
        height: imageHeight,
        width: double.infinity,
      );
      actor.idHero = '${actor.idHero}_latest';
      return Hero(
        tag: actor.idHero,
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

    Widget _actorName(BuildContext context) {
      final textStyle = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
          fontFamily: 'Cinzel');

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: imageHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              actor.name,
              style: textStyle,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                extras.buildBoxTag(actor.knownForDepartment, Colors.teal),
                SizedBox(width: 25),
                extras.buildActorPopularity(actor.popularity),
                SizedBox(width: 25),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'actor', arguments: actor);
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.info_outline, color: Colors.white),
                      Text(
                        S.of(context).info,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

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
            _actorName(context),
            //appBar,
          ],
        ),
      ),
    );
    return poster;
  }

  Widget buildBestActors(BuildContext context) {
    final res = PageViewActor(futureActors: movieApi.getPopularActors());
    return extras.buildSection(
        title: S.of(context).most_popular,
        child: res,
        textBackground: S.of(context).actors,
        paddingHeader: paddingSections);
  }
}
