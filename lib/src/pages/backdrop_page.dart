import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:movies/common/extras.dart';
import 'package:movies/src/models/image_model.dart';
import 'package:photo_view/photo_view.dart';

class MoviePosterPage extends StatefulWidget {
  @override
  _MoviePosterPageState createState() => _MoviePosterPageState();
}

class _MoviePosterPageState extends State<MoviePosterPage> {
  int _progress = 0;
  String _message = "";
  String _path = "";
  String _size = "";
  String _mimeType = "";
  File _imageFile;

  @override
  void initState() {
    super.initState();

    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });
  }

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
        onPressed: () {
          _downloadImage(image.getLargePathUrl());
          /*
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
           */
        });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text((_progress == 0 || _progress == 100)
              ? 'Votos ${image.voteCount}'
              : 'Descargando: $_progress %'),
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

  Future<void> _downloadImage(String url,
      {AndroidDestinationType destination,
      bool whenError = false,
      String outputMimeType}) async {
    String fileName;
    String path;
    int size;
    String mimeType;
    try {
      String imageId;

      if (whenError) {
        imageId = await ImageDownloader.downloadImage(url,
                outputMimeType: outputMimeType)
            .catchError((error) {
          if (error is PlatformException) {
            var path = "";
            if (error.code == "404") {
              print("Not Found Error.");
            } else if (error.code == "unsupported_file") {
              print("UnSupported FIle Error.");
              path = error.details["unsupported_file_path"];
            }
            setState(() {
              _message = error.toString();
              _path = path;
            });
          }

          print(error);
        }).timeout(Duration(seconds: 10), onTimeout: () {
          print("timeout");
          return;
        });
      } else {
        if (destination == null) {
          imageId = await ImageDownloader.downloadImage(
            url,
            outputMimeType: outputMimeType,
          );
        } else {
          imageId = await ImageDownloader.downloadImage(
            url,
            destination: destination,
            outputMimeType: outputMimeType,
          );
        }
      }

      if (imageId == null) {
        return;
      }
      fileName = await ImageDownloader.findName(imageId);
      path = await ImageDownloader.findPath(imageId);
      size = await ImageDownloader.findByteSize(imageId);
      mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      setState(() {
        _message = error.message;
      });
      return;
    }

    if (!mounted) return;

    setState(() {
      var location = Platform.isAndroid ? "Directory" : "Photo Library";
      _message = 'Saved as "$fileName" in $location.\n';
      _size = 'size:     $size';
      _mimeType = 'mimeType: $mimeType';
      _path = path;

      if (!_mimeType.contains("video")) {
        _imageFile = File(path);
      }
      return;
    });
  }
}
