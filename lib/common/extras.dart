import 'package:flutter/material.dart';

class Extras {
  List<Widget> buildstarts(double votes, int maxStart) {
    // Starts
    Widget _buildStarIcon(IconData icon) => Container(
          decoration: BoxDecoration(),
          child: Icon(icon, color: Colors.yellow[900], size: 12),
        );
    List<Widget> starts = [];
    int avg = votes.toInt();
    bool halfStart = ((votes - avg) * 100) > maxStart;
    for (var i = 0; i < avg; i++) {
      starts.add(_buildStarIcon(Icons.star));
    }
    if (halfStart) {
      avg++;
      starts.add(_buildStarIcon(Icons.star_half));
    }
    ;
    for (var i = 0; i < (maxStart - avg); i++) {
      starts.add(_buildStarIcon(Icons.star_border));
    }
    return starts;
  }

  Widget buildPosterImg(String urlImage, double imgHeight, double imgWidth,
      {double corners = 10, assetImgName='no-image-3.png'}) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(corners),
        child: FadeInImage(
          placeholder: AssetImage('assets/img/$assetImgName'),
          image: NetworkImage(urlImage),
          fit: BoxFit.cover,
          height: imgHeight,
          width: imgWidth,
        ));
  }
}
