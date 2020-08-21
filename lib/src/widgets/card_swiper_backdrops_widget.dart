import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/generated/l10n.dart';
import 'package:movies/src/models/image_model.dart';

import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class SwiperBackdrops extends StatelessWidget {
  Extras extras = Extras();
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
            Text(S.of(context).no_images_available,
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
              child: extras.buildBackdropCard(image,
                  padding: EdgeInsets.symmetric(horizontal: 10.0)),
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
}
