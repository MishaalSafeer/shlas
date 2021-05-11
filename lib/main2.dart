import 'package:flutter/material.dart';
import 'package:auth/main.dart';
import 'package:auth/pages/SplashApp.dart';

void main() {
  runApp(
    SplashApp(
      key: UniqueKey(),
      onInitializationComplete: () => runMyApp(),
    ),
  );
}

void runMyApp() {
  runApp(
    MyApp(),
  );
}