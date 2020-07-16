import 'package:flutter/material.dart';
import 'package:movies/env/app_env.dart';
import 'package:movies/locator.dart';
import 'package:movies/main.dart';

void main() {
  setupLocator();
  AppEnvironment.setupEnv(Environment.prod);
  runApp(MyApp());
}