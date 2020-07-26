import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/widgets/loading_data_widget.dart';

class PageViewSection extends StatefulWidget {
  final String titleSection;
  final Stream<List<Movie>> moviesStream;
  final Function() sinkNextPage;
  final Map<String, dynamic> args;

  PageViewSection(
      {@required this.titleSection,
      @required this.moviesStream,
      @required this.sinkNextPage,
      @required this.args});

  @override
  _PageViewSectionState createState() => _PageViewSectionState();
}

class _PageViewSectionState extends State<PageViewSection> {
  Extras extras = Extras();
  Size _screenSize;
  PageController _pageController;
  EdgeInsets paddingSections =
      EdgeInsets.symmetric(vertical: 0, horizontal: 20);

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _pageController = PageController(initialPage: 1, viewportFraction: 0.375);

    widget.sinkNextPage();
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        widget.sinkNextPage();
      }
    });
    return extras.buildSection(
        title: widget.titleSection,
        child: _getStreamData(context),
        paddingHeader: paddingSections);
  }

  Widget _buildCard(BuildContext context, Movie movie) {
    final posterCropped = extras
        .buildPosterImg(movie.getPosterImgUrl(), 175.0, 110.0, corners: 5);
    String movie_title = movie.title.length > 28
        ? '${movie.title.substring(0, 28)}...'
        : movie.title;
    final textStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white70);
    final details = Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: extras.buildstarts(movie.voteAverage / 2, 5)),
          SizedBox(height: 2.0),
          Text(movie_title, overflow: TextOverflow.fade, style: textStyle),
        ],
      ),
    );
    final res = Container(
      child: Column(
        children: <Widget>[
          Hero(tag: movie.idHero, child: posterCropped),
          details
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'movie_detail', arguments: {
          'movie': movie,
        });
      },
      child: ZoomIn(
        delay: Duration(microseconds: 100),
        child: res,
      ),
    );
  }

  Widget _getStreamData(BuildContext context) {
    return StreamBuilder(
        stream: widget.moviesStream,
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top: 25, bottom: 25),
              child: LoadingData(),
            );
          }
          final movies = snapshot.data;
          return Container(
            height: _screenSize.height * 0.313,
            child: PageView.builder(
              pageSnapping: false,
              controller: _pageController,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildCard(context, movies[index]),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    //widget.bloc.disposeStream();
  }
}
