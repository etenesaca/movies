import 'package:flutter/material.dart';
import 'package:movies/src/widgets/loader_widget.dart';

class LoadingData extends StatelessWidget {
  String assetFile;

  LoadingData([this.assetFile = 'loading-10.svg']);

  @override
  Widget build(BuildContext context) {
    /* 
    final imgPath = 'assets/img/$assetFile';
    Widget img = assetFile.contains('.svg')
        ? FlareActor(imgPath,
            alignment: Alignment.center, fit: BoxFit.contain, animation: "idle")
        : Image.asset(imgPath);

    return Center(child: img);
    */
    return Center(
      child: LoaderWidget(),
    );
  }
}
