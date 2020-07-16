import 'package:flutter/material.dart';

class Extras {
  List<Widget> buildstarts(double votes, int maxStart) {
    // Starts
    Widget _buildStarIcon(IconData icon) =>
        Icon(icon, color: Colors.yellow[900], size: 12);
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
}
