import 'package:flutter/material.dart';
import 'dart:async';

class Debouncer {
  Timer _timer;

  void run(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: 1000), callback);
  }
}
