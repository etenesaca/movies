import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/image_model.dart';

import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class SwiperBackdrops extends StatelessWidget {
  List<Backdrop> images;
  Size _screenSize;
  SwiperBackdrops({@required this.images});

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
        return _buildCard(context, images[index]);
      },
      itemCount: images.length,
      itemWidth: itemWidth,
      //viewportFraction: .67,
      viewportFraction: .67,
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

  Widget _buildCard(BuildContext context, Backdrop image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[_buildImage(context, image)],
      ),
    );
  }

  Widget _buildImage(BuildContext context, Backdrop image) {
    double _cardCorners = 5.0;
    final posterCropped = ClipRRect(
        borderRadius: BorderRadius.circular(_cardCorners),
        child: FadeInImage(
          placeholder: AssetImage('assets/img/no-image.jpg'),
          image: image.getImg(),
          fit: BoxFit.cover,
          //width: double.infinity,
        ));

    return posterCropped;
  }
}
