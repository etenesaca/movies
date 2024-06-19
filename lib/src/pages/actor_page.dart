import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/apis/the_movie_db_api.dart';
import 'package:movies/src/widgets/card_swiper_backdrops_widget.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';
import 'package:movies/src/widgets/page_view_actor_movies_widget.dart';

class ActorPage extends StatelessWidget {
  MovieProvider movieApi = MovieProvider();
  Extras extras = Extras();
  Color? mainColor;
  Size? _screenSize;

  EdgeInsets paddingSections =
      EdgeInsets.symmetric(vertical: 0, horizontal: 20);

  @override
  Widget build(BuildContext context) {
    Actor actor = ModalRoute.of(context)!.settings.arguments as Actor;
    _screenSize = MediaQuery.of(context).size;
    mainColor = Extras().mainColor;

    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: <Widget>[
          extras.getBackgroundApp(),
          CustomScrollView(
            slivers: <Widget>[
              _buildAppBar(actor),
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: <Widget>[_buildInfo(actor)],
                  )
                ]),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget setPaddingsection(Widget child) {
    return Padding(padding: paddingSections, child: child);
  }

  Widget _buildInfo(Actor actor) {
    return FutureBuilder(
      future: movieApi.getActorDetail(actor.id!),
      builder: (BuildContext context, AsyncSnapshot<Actor> snapshot) {
        if (!snapshot.hasData) {
          return LoadingData();
        }
        final idHeroActor = actor.idHero;
        actor = snapshot.data!;
        actor.idHero = idHeroActor;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: _buildSec1(actor),
            ),
            setPaddingsection(_buildBith(actor)),
            _buildSectionImages(context, actor),
            _buildMovieRelateds(context, actor),
            (actor.biography != '')
                ? _buildBiography(actor)
                : SizedBox(
                    height: 20,
                  ),
          ],
        );
      },
    );
  }

  Widget _buildSec1(Actor actor) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ZoomIn(
            delay: Duration(microseconds: 100),
            child: extras.buildBoxTag(actor.knownForDepartment!, Colors.teal),
          ),
          SizedBox(
            width: 20,
          ),
          ZoomIn(
            delay: Duration(microseconds: 100),
            child: extras.buildActorPopularity(actor.popularity!),
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
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: <Widget>[
          _geTitleSection('Biografía'),
          SizedBox(height: 10),
          Text(
            actor.biography!,
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  _buildBith(Actor actor) {
    int age = 0;
    if (actor.deathday == null && actor.birthday != null) {
      try {
        age = extras.calculateAge(DateTime.parse(actor.birthday.toString()));
      } catch (e) {}
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _geTitleSection('Fecha de nacimiento'),
              (age > 0)
                  ? Text(
                      '$age años',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    )
                  : Container()
            ],
          ),
          SizedBox(height: 5),
          Text(
            (actor.birthday != null)
                ? '${actor.birthday} - ${actor.placeOfBirth}'
                : '--',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.white70),
          ),
          (actor.deathday != null && actor.birthday != null)
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
    double heightCard = 150;
    double widthCard = heightCard + heightCard * .40;
    final imagesCards = FutureBuilder(
        future: MovieProvider().getActorImagesList(actor.id!),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return SwiperBackdrops(
                images: snapshot.data,
                heightCard: heightCard,
                widthCard: widthCard);
          } else {
            return LoadingData();
          }
        });

    final showAllImages = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(), backgroundColor: Colors.white10),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.photo_library,
                  color: Colors.orangeAccent,
                  size: 15,
                ),
                SizedBox(width: 5),
                Text('Ver todo',
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold))
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'galery',
                  arguments: movieApi.getActorImagesList(actor.id!));
            },
          ),
        )
      ],
    );
    return extras.buildSection(
        title: '',
        child: Container(
          height: heightCard,
          child: imagesCards,
        ),
        textBackground: actor.name,
        action: showAllImages,
        paddingHeader: EdgeInsets.only(left: 20, right: 5, top: 10));
  }

  Widget _buildMovieRelateds(BuildContext context, Actor actor) {
    final res =
        PageViewMovieSection(futureMovies: movieApi.getActorMovies(actor));
    return extras.buildSection(
        title: 'Peliculas en las que aparece',
        child: res,
        textBackground: 'movies',
        paddingHeader: paddingSections);
  }

  Widget _buildAppBar(Actor actor) {
    double imageHeight = _screenSize!.height * 0.6;
    Widget _imagePoster() {
      Widget res = FadeInImage(
        placeholder: AssetImage('assets/img/loading.gif'),
        image: actor.getPhotoImg(),
        fit: BoxFit.cover,
        height: imageHeight,
        width: double.infinity,
      );
      return Hero(
        tag: actor.idHero!,
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
              mainColor!.withOpacity(0.0),
              mainColor!.withOpacity(0.3),
              mainColor!.withOpacity(0.5),
              mainColor!.withOpacity(0.7),
              mainColor!.withOpacity(0.8),
              mainColor!.withOpacity(0.9),
              mainColor!,
            ])),
      );
    }

    Widget _actorName() {
      final textStyle = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 33,
          fontFamily: 'Cinzel');
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        height: imageHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              actor.name!,
              style: textStyle,
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
            _actorName(),
            //appBar,
          ],
        ),
      ),
    );

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Extras().mainColor,
      expandedHeight: imageHeight,
      floating: false,
      pinned: true,
      title: Text('Perfil'),
      centerTitle: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: poster,
      ),
    );
  }
}
