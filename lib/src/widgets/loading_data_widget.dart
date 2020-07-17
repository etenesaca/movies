import 'package:flutter/material.dart';

class LoadingData extends StatelessWidget {
  String assetFile;

  LoadingData([this.assetFile = 'Curve-Loading.gif']);

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset('assets/img/$assetFile'));
  }
}
