import 'package:flutter/material.dart';

class Extras {
  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  List<Widget> buildstarts(double votes, int maxStart) {
    // Starts
    Widget _buildStarIcon(IconData icon, Color color) => Container(
          decoration: BoxDecoration(),
          child: Icon(icon, color: color, size: 12),
        );
    List<Widget> starts = [];
    int avg = votes.toInt();
    bool halfStart = ((votes - avg) * 100) > maxStart;
    for (var i = 0; i < avg; i++) {
      starts.add(_buildStarIcon(Icons.star, Colors.yellow[800]));
    }
    if (halfStart) {
      avg++;
      starts.add(_buildStarIcon(Icons.star_half, Colors.yellow[800]));
    }
    ;
    for (var i = 0; i < (maxStart - avg); i++) {
      starts.add(_buildStarIcon(Icons.star, Colors.brown[800]));
    }
    return starts;
  }

  Widget buildPosterImg(String urlImage, double imgHeight, double imgWidth,
      {double corners = 10, assetImgName = 'placeholder-dark-2.png'}) {
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

  Widget buildPlaceholderImg(double imgHeight, double imgWidth,
      {double corners = 10, assetImgName = 'placeholder-dark-2.png'}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(corners),
      child: Image.asset(
        'assets/img/$assetImgName',
        fit: BoxFit.cover,
        height: imgHeight,
        width: imgWidth,
      ),
    );
  }

  Color mainColor = Color.fromRGBO(24, 33, 46, 1.0);
  LinearGradient getBackgroundGradientApp() {
    return LinearGradient(
        begin: FractionalOffset(.0, 0.5),
        end: FractionalOffset(0.0, 1.0),
        colors: [
          mainColor,
          Color.fromRGBO(24, 33, 46, 1.0),
          Color.fromRGBO(37, 51, 72, 1.0),
          Color.fromRGBO(57, 79, 111, 1.0),
        ]);
  }

  Widget getBackgroundApp() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(gradient: Extras().getBackgroundGradientApp()),
    );
  }

  Widget buildBoxTag(String label, Color color) {
    final txtStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.white);
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 13),
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(30.0), color: color),
      child: Text(label, style: txtStyle),
    );
  }
}
