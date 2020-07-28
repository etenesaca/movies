import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/image_model.dart';
import 'package:photo_view/photo_view.dart';

class MoviePosterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Extras extras = Extras();
    Backdrop image = ModalRoute.of(context).settings.arguments;
    Color mainColor = extras.mainColor;

    final imgviewer = PhotoView(
      imageProvider: image.getImgLarge(),
      backgroundDecoration: BoxDecoration(color: mainColor),
    );
    Widget btnApplyWallpaper = FloatingActionButton(
        heroTag: 'btnApplyWallpaper',
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.image),
        onPressed: () {});
    Widget btnDownload = FloatingActionButton(
        heroTag: 'btnDownload',
        backgroundColor: Colors.teal,
        child: Icon(Icons.cloud_download),
        onPressed: () async {
          try {
            // Saved with this method.
            var imageId =
                await ImageDownloader.downloadImage(image.getLargePathUrl());
            if (imageId == null) {
              return;
            }
            // Below is a method of obtaining saved image information.
            var fileName = await ImageDownloader.findName(imageId);
            var path = await ImageDownloader.findPath(imageId);
            var size = await ImageDownloader.findByteSize(imageId);
            var mimeType = await ImageDownloader.findMimeType(imageId);
          } on PlatformException catch (error) {
            print(error);
          }
        });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text('Votos ${image.voteCount}'),
        ),
        backgroundColor: mainColor,
        body: imgviewer,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ZoomIn(
              child: btnApplyWallpaper,
              duration: Duration(milliseconds: 700),
            ),
            SizedBox(
              width: 5,
            ),
            ZoomIn(
              child: btnDownload,
              duration: Duration(milliseconds: 700),
            )
          ],
        ));
  }

  /*
          @override
          Widget build(BuildContext context) {
            Size _screenSize = MediaQuery.of(context).size;
        
            double imageHeight = _screenSize.height * 0.6;
            Backdrop image = ModalRoute.of(context).settings.arguments;
        
            Widget btnApplyWallpaper = FloatingActionButton(
                heroTag: 'btnApplyWallpaper',
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.image),
                onPressed: () {});
            Widget btnDownload = FloatingActionButton(
                heroTag: 'btnDownload',
                backgroundColor: Colors.teal,
                child: Icon(Icons.cloud_download),
                onPressed: () {});
            return Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  _buildAppBar(image, imageHeight),
                  SliverList(delegate: SliverChildListDelegate([]))
                ],
              ),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ZoomIn(
                    child: btnApplyWallpaper,
                    duration: Duration(milliseconds: 500),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ZoomIn(
                    child: btnDownload,
                    duration: Duration(milliseconds: 500),
                  )
                ],
              ),
              /* 
        
              ZoomIn(
                child: buttonDownload,
                duration: Duration(milliseconds: 500),
              )
        
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                      backgroundColor: Colors.redAccent,
                      child: Icon(Icons.image),
                      onPressed: () {}),
                  SizedBox(width: 5),
                  ,
              */
            );
          }
        
          Widget _buildAppBar(Backdrop image, double height) {
            final img = FadeInImage(
              image: image.getImgLarge(),
              placeholder: AssetImage('assets/img/loading.gif'),
              fadeInDuration: Duration(milliseconds: 100),
              fit: BoxFit.cover,
            );
            final imgviewer = PhotoView(
              imageProvider: image.getImgLarge(),
              backgroundDecoration: BoxDecoration(
                color: Extras().main
              ),
            );
            return SliverAppBar(
              elevation: 2.0,
              backgroundColor: Extras().mainColor,
              expandedHeight: height,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: imgviewer,
              ),
            );
        
        
            return SliverAppBar(
              elevation: 2.0,
              backgroundColor: Extras().mainColor,
              expandedHeight: height,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: FadeInImage(
                  image: image.getImgLarge(),
                  placeholder: AssetImage('assets/img/loading.gif'),
                  fadeInDuration: Duration(milliseconds: 100),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
         */

}
