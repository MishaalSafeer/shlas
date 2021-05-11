import 'package:auth/main3.dart';
import 'package:flutter/material.dart';
import 'package:auth/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashApp extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  final bool initializationShouldFail;

  const SplashApp({
    Key key,
    @required this.onInitializationComplete,
    this.initializationShouldFail = false,
  }) : super(key: key);

  @override
  _SplashAppState createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp> {
  bool _hasError = false;
  String uid;

  @override
  void initState() {
    super.initState();
    if (widget.initializationShouldFail) {
      fakeLoadingAndError();
    } else {
      fakeLoadingAndSuccess();
    }
  }

  Future<void> fakeLoadingAndError() async {
    Future.delayed(
      Duration(milliseconds: 1500),
          () {
        setState(() {
          _hasError = true;
        });
      },
    );
  }

  Future<void> fakeLoadingAndSuccess() async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
    // >>> initialize async dependencies <<<
    // >>> register favorite dependency manager <<<
    // >>> reap benefits <<<
    Future.delayed(
      Duration(milliseconds: 1500),
          () => widget.onInitializationComplete(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_hasError) {
      return Center(
        child: RaisedButton(
          onPressed: () => main2(),
          child: Text('retry'),
        ),
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}