import 'package:flutter/material.dart';
import 'package:movies/env/app_env.dart';
import 'package:movies/main.dart';

import 'locator.dart';

void main() {
  setupLocator();
  AppEnvironment.setupEnv(Environment.dev);
  runApp(MyApp());
}