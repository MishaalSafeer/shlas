import 'package:auth/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:auth/Services/auth.dart';
import 'package:auth/Services/auth_provider.dart';
import 'package:auth/pages/root_page.dart';
import 'package:auth/main2.dart';



class newpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //backgroundColor: Color(0xFF32323e),
      appBar: AppBar(
        title: Text('Welcome', style: TextStyle(
            fontSize: 35,
            height: 1.0,
            fontWeight: FontWeight.bold,
            color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body:RaisedButton(
        child: Text('Move to Home Page'),
        onPressed: () {

        }),

      floatingActionButton: FloatingActionButton(
        splashColor: Colors.green,

        onPressed:(){ main();},
      ),

    );
  }
}