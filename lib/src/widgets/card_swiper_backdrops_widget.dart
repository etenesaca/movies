import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/image_model.dart';

import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class SwiperBackdrops extends StatelessWidget {
  List<Backdrop> images;
  Size _screenSize;
  double _cardCorners = 8.0;
  final double heightCard;
  final double widthCard;

  SwiperBackdrops(
      {@required this.images,
      @required this.heightCard,
      @required this.widthCard});

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    final itemWidth = _screenSize.width * .4;
    if (images.isEmpty) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.image, color: Colors.grey),
            Text('No hay imagenes disponibles',
                style: TextStyle(color: Colors.grey))
          ],
        ),
      );
    }
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        final image = images[index];
        return GestureDetector(
            child: ZoomIn(
              duration: Duration(milliseconds: 500),
              child: _buildCard(context, image),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'movie_poster', arguments: image);
            });
      },
      itemCount: images.length,
      itemWidth: heightCard,
      itemHeight: widthCard,
      viewportFraction:
          Extras().getViewportFraction(_screenSize.width, widthCard),
      //scale: .75,
      indicatorLayout: PageIndicatorLayout.COLOR,
      pagination: _buiidPagination(),
      control: new SwiperControl(),
    );
  }

  _buiidPagination() {
    return SwiperPagination(
        builder: SwiperPagination.fraction, alignment: Alignment.bottomCenter);
  }

  Widget _buildImageVotes(Backdrop image) {
    final color = Colors.white;
    final shadows = BoxShadow(
      color: Colors.black.withOpacity(0.9),
      spreadRadius: 5,
      blurRadius: 15,
      offset: Offset(1, 6), // changes position of shadow
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      decoration: BoxDecoration(
          boxShadow: [shadows],
          color: Colors.black87,
          border: Border.all(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: <Widget>[
          Text(
            '${image.voteCount}',
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: 10),
          ),
          SizedBox(width: 2.0),
          Icon(
            Icons.thumb_up,
            color: color,
            size: 10.0,
          )
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, Backdrop image) {
    final votes = Container(
      padding: EdgeInsetsDirectional.only(start: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget>[_buildImageVotes(image)],
          )
        ],
      ),
    );
    final posterCropped = Extras().buildPosterImg(
        image.getPathUrl(), double.infinity, double.infinity,
        corners: 5.0, assetImgName: 'toro.gif');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[posterCropped, votes],
      ),
    );
  }
}
