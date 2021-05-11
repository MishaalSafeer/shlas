import 'package:flutter/material.dart';
import 'package:auth/main.dart';
import 'package:auth/pages/SplashApp.dart';
import 'package:auth/pages/MainDrawer.dart';

void main2() {
  runApp(
    SplashApp(
      key: UniqueKey(),
      onInitializationComplete: () => runMyApp(),
    ),
  );
}

void runMyApp() {
  runApp(
    bed(),
  );
}