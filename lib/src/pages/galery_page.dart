import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/image_model.dart';
import 'package:movies/src/widgets/loader_widget.dart';

class GaleryPage extends StatelessWidget {
  Extras extras = Extras();
  Future<List<Backdrop>>? callBackImages;
  Size? _screenSize;

  @override
  Widget build(BuildContext context) {
    callBackImages =
        ModalRoute.of(context)!.settings.arguments as Future<List<Backdrop>>?;
    _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: extras.mainColor,
      appBar: AppBar(
        title: Text('Galeria'),
        backgroundColor: Colors.transparent,
      ),
      body: buildGridView(),
    );
  }

  buildGridView() {
    return FutureBuilder(
        future: callBackImages,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoaderWidget(),
            );
          }
          final images = snapshot.data;
          return GridView.builder(
              reverse: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    extras.calCrossAxisItems(_screenSize!.width, 120),
                mainAxisSpacing: 7,
                crossAxisSpacing: 7,
                //childAspectRatio: 1.5
              ),
              itemCount: images.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                final image = images[index];
                return GestureDetector(
                    child: ZoomIn(
                      duration: Duration(milliseconds: 500),
                      child: extras.buildBackdropCard(image),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, 'movie_poster_child',
                          arguments: image);
                    });
              });
        });
  }
}
