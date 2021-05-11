import 'package:flutter/material.dart';
import 'package:auth/Services/auth.dart';
import 'package:auth/Services/auth_provider.dart';
import 'package:auth/pages/root_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        theme: new ThemeData(
          accentColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          backgroundColor: Colors.white,
          dialogBackgroundColor: Colors.black,
        ),
        home:new RootPage(auth:new Auth()),
      ),
    );
  }
}