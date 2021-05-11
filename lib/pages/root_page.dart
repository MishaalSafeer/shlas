import 'package:flutter/material.dart';
import '../Services/auth.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../Services/auth_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/main2.dart';
import 'package:auth/global.dart'as g;

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notDetermined;
  //final FirebaseAuth _auth=FirebaseAuth.instance;

  //var uid;
  String _userId = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final BaseAuth auth = AuthProvider.of(context).auth;
    auth.currentUser().then((String userId) {
      setState(() {
        _userId=userId;
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        //main();


      });

    });
  }

  void _signedIn() {

    setState((){
      authStatus = AuthStatus.signedIn;

    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }




  @override
  Widget build(BuildContext context) {


    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return LoginPage(
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        //if(_userId.length>0 && _userId!=null)
         return HomePage(
          onSignedOut:_signedOut,
          userId: _userId,
        );
        //else
        //{return _buildWaitingScreen();}
    }
    return _buildWaitingScreen();
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          backgroundColor: Colors.green,
        ),
        color: Colors.green,




      ),
    );
  }
}


