import 'package:flutter/material.dart';
import 'dart:async';

class Debouncer {
  Timer? _timer;

  void run(VoidCallback callback, milliseconds) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), callback);
  }
}
