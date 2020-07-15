import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/widgets/sliver_movie_poster_widget.dart';

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //_buildAppBar(movie),
          _buildSliverPoster(movie),
          //_buildPosterContent(movie),
          SliverList(
              delegate: SliverChildListDelegate([
            //_buildPosterMovie(context, movie),
            SizedBox(
              height: 10.0,
            ),
            //_buildPosterMovie(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            _buildDescription(context, movie),
            //_buildCast(context, pelicula),
          ]))
        ],
      ),
    );
  }

  _buildSliverPoster(Movie movie) {
    return SliverPersistentHeader(
      delegate: SliverMoviePoster(expandedHeight: 250, movie: movie),
      pinned: true,
    );
  }

  _buildAppBar(Movie movie) {
    Widget res = SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(movie.title),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: movie.getBackgroundImg(),
          fit: BoxFit.cover,
        ),
      ),
    );
    return res;
  }

  _buildDescription(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            movie.overview,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }

  Widget _buildPosterContent(Movie movie) {
    final res = TransitionAppBar(
      extent: 160,
      avatar: ClipRRect(
        child: Image(
          image: movie.getPosterImg(),
          //height: 160.0,
        ),
        borderRadius: BorderRadius.circular(7.0),
      ),
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Row(children: <Widget>[]),
      ),
    );
    return res;
  }

  _buildPosterMovie(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.idHero,
            child: ClipRRect(
              child: Image(
                image: movie.getPosterImg(),
                height: 150.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                style: Theme.of(context).textTheme.title,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                movie.originalTitle,
                style: Theme.of(context).textTheme.subhead,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subhead,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}

class TransitionAppBar extends StatelessWidget {
  final Widget avatar;
  final Widget title;
  final double extent;

  TransitionAppBar({this.avatar, this.title, this.extent = 250, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
          avatar: avatar, title: title, extent: extent > 200 ? extent : 200),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _avatarMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(bottom: 70, left: 30),
      end: EdgeInsets.only(left: 0.0, top: 30.0));
  final _avatarAlignTween =
      AlignmentTween(begin: Alignment.bottomLeft, end: Alignment.topCenter);

  final Widget avatar;
  final Widget title;
  final double extent;

  _TransitionAppBarDelegate({this.avatar, this.title, this.extent = 250})
      : assert(avatar != null),
        assert(extent == null || extent >= 200),
        assert(title != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 34 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
    print("Objechjkf === ${progress} ${shrinkOffset}");
    final avatarMargin = _avatarMarginTween.lerp(progress);
    final avatarAlign = _avatarAlignTween.lerp(progress);

    return Stack(
      children: <Widget>[
        /** 
         * 
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: shrinkOffset * 2,
          constraints: BoxConstraints(maxHeight: minExtent),
          //color: Colors.redAccent,
        ),
        */
        Padding(
          padding: avatarMargin,
          //child: Align(alignment: avatarAlign, child: avatar),
          child: avatar,
        ),
        /**
         * 
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: title,
          ),
        )
        */
      ],
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => (maxExtent * 70) / 100;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }
}
