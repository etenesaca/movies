import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/image_model.dart';

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
      {
        double corners = 10, 
        assetImgName = 'placeholder-dark-2.png',
        fit = BoxFit.cover
        }) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(corners),
        child: FadeInImage(
          placeholder: AssetImage('assets/img/$assetImgName'),
          image: NetworkImage(urlImage),
          fit: fit,
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

  Widget buildBoxTag(String label, Color color,
      {EdgeInsets padding, double textSize, Color textColor}) {
    final txtStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: textSize != null ? textSize : 12.0,
        color: textColor != null ? textColor : Colors.white);
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      padding: padding != null
          ? padding
          : EdgeInsets.symmetric(vertical: 4, horizontal: 13),
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(30.0), color: color),
      child: Text(label, style: txtStyle),
    );
  }

  Widget buildActorPopularity(double popularity) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(Icons.stars, color: Colors.orange, size: 15),
          SizedBox(
            width: 3,
          ),
          Text(
            '$popularity',
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildTitleSection(String text) {
    final titleSection = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.white);
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(text, style: titleSection));
  }

  buildSection(
      {@required String title,
      @required Widget child,
      bool showBackground = true,
      String textBackground,
      Widget action,
      EdgeInsets paddingHeader}) {
    if (paddingHeader == null) {
      paddingHeader = EdgeInsets.symmetric();
    }
    if (textBackground == null) {
      textBackground = title;
    }
    if (action == null) {
      action = Container();
    }
    final header = Padding(
        padding: paddingHeader,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[buildTitleSection(title), action],
        ));
    final res = Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[header, SizedBox(height: 10), child],
      ),
    );
    final background = (showBackground)
        ? Padding(
            padding: paddingHeader,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Text(textBackground,
                  style: TextStyle(
                      color: Colors.white10,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RussoOne')),
            ),
          )
        : Container();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Stack(
        children: <Widget>[background, res],
      ),
    );
  }

  Widget buildAvatar(Color avatarColor, String name,
      [NetworkImage image, double avatarSize]) {
    final styleShadow = BoxShadow(
      color: Colors.black.withOpacity(0.9),
      spreadRadius: 1,
      blurRadius: 15,
      offset: Offset(3, 3), // changes position of shadow
    );

    Widget actorPhoto;
    if (image == null) {
      actorPhoto = Center(
          child: Text(
        name.substring(0, 2).toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
    } else {
      actorPhoto = CircleAvatar(
        radius: avatarSize - 2,
        backgroundImage: image,
      );
    }

    Widget avatar = CircleAvatar(
      radius: avatarSize,
      backgroundColor: avatarColor,
      child: actorPhoto,
    );
    avatar = Container(
      decoration: BoxDecoration(
        boxShadow: [styleShadow],
        shape: BoxShape.circle,
      ),
      child: avatar,
    );
    return avatar;
  }

  double getViewportFraction(double widthScreen, double widthCard,
      {double widthSeparator = 25}) {
    double wCard = widthCard + widthSeparator;
    double aux = (widthScreen / wCard);
    double pxCU = widthScreen / aux;
    double percent = (100 / widthScreen) * pxCU;
    return percent / 100;
  }

  int calCrossAxisItems(double widthScreen, double sizeCard) {
    double wCard = sizeCard;
    double numItems = (widthScreen / wCard);
    return numItems.toInt();
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

  Widget buildBackdropCard(Backdrop image,
      {EdgeInsets padding, bool smaillImage = false}) {
    if (padding == null) {
      padding = const EdgeInsets.symmetric();
    }
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
    final imagePath =
        smaillImage ? image.getSmallPathUrl() : image.getPathUrl();
    final posterCropped = Extras().buildPosterImg(
        imagePath, double.infinity, double.infinity,
        corners: 5.0, assetImgName: 'popcorn.gif');
    return Padding(
      padding: padding,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[posterCropped, votes],
      ),
    );
  }
}
