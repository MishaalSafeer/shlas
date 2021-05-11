import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Services/auth.dart';
import '../Services/auth_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import '../pages/SMContainer.dart';
import '../pages/MainDrawer.dart';
import '../pages/settings.dart';
import 'package:auth/main2.dart';
import '../pages/buttonpage.dart' as b;
import 'package:auth/global.dart' as globals;
import 'package:auth/pages/slider.dart';
import 'package:flutter_extension/flutter_extension.dart';

extension ColorUtils on Color{
  Color mix(Color another,double amount){
    return Color.lerp(this,another,amount);
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _text;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var s = new List();
  //String id;

  final databasereference2 = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    super.initState();
    _text = new List();
    databasereference2
        .child('users')
        .child(widget.userId)
        .child('rooms')
        .onChildAdded
        .listen((event) {
      var snapshot = event.snapshot;
      if (this.mounted)
        setState(() {
          _text.add(snapshot.value['room']);
        });
    });
    print(widget.userId);
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_text);
    return Scaffold(
      backgroundColor: Colors.black,
      //backgroundColor: Color(0xFF32323e),
      appBar: AppBar(
        title: Text(
          'HOME',
          style: TextStyle(
              fontSize: 35,
              height: 1.0,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          FlatButton(
            child: Text('Logout',
                style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: ()=>_signOut(context),

          ),

          /* FlatButton(
            child:Text('Refresh', style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: ()=> getData(),
          )*/
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 16,
            right: 0,
            top: 38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 52,
                ),
                Container(
                  height: 80,
                  child: Row(
                    children: <Widget>[
                      SMConationer2(
                          bevel: 10,
                          shapes: false,
                          child: Icon(
                            Icons.battery_charging_full,
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: "Power units",
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 34,
                                color: Colors.white,
                              ),
                            ),
                          ])),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            " Check Power Usage",
                            style: TextStyle(
                              color: Colors.white.withOpacity(
                                1,
                              ),
                              fontWeight: FontWeight.w200,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 270,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 16, top: 16, bottom: 16, right: 16),
                        width: 200,
                        child: SMConationer3(
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: -16,
                                top: 64,
                                child: Container(
//                                        width: 20,
//                                        height: 100,
//                                        margin: EdgeInsets.all(5),
//                                        padding: EdgeInsets.only(top: 13),
                                  alignment: Alignment.center,
                                  // alignment: Alignment(0.9,-0.9),
                                  //child:
//                                  Image(
//                                    image: AssetImage('assets/bedroom.jpg'),
//                                    fit: BoxFit.cover,
//                                  ),

//                                  decoration: BoxDecoration(
//                                    borderRadius: BorderRadius.circular(20), image: DecorationImage(
//                                    image: AssetImage('assets/bedroom.jpg'),
//                                  )
//                                  ),
                                ),
                              ),
                              Positioned(
                                left: -2,
                                bottom: 35,
                                top: 80,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'ADD ROOM',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          shapes: false,
                          padding: EdgeInsets.only(
                            bottom: 24,
                          ),
                          id: widget.userId,
                          //c:_text[i]
                        ),
                      ),
                      for(var i=0;i<_text.length;i++)
                        Container(
                          margin: EdgeInsets.only(
                              left: 16, top: 16, bottom: 16, right: 16),
                          width: 200,
                          child: SMConationer1(
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: -16,
                                  top: 64,
                                  child: Container(
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Positioned(
                                  left: 9,
                                  bottom: 35,
                                  top: 80,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _text[i],
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            shapes: false,
                            padding: EdgeInsets.only(
                              bottom: 24,
                            ),
                            ide: widget.userId,
                            c:_text[i],
                          ),
                        ),
                      Container(
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 120,
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.grey.shade50,
                      Colors.grey.shade200,
                      Colors.grey.shade300,
                      Colors.blueGrey.shade200,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 16,
                        offset: Offset(-24, 8),
                        color: Colors.white),
                  ]),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      height: 6,
                      width: 52,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  new MaterialButton(
                    height: 80.0,
                    minWidth: double.infinity,
                    textColor: Colors.white,
                    child: new Text(
                      "SCHEDULE",
                      style: new TextStyle(
                        fontSize: 25.0,
                        color: Colors.black87,
                      ),
                    ),
                    onPressed: () => {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => slider()),),
                    },
                    //splashColor: Colors.redAccent,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        splashColor: Colors.black,
        onPressed: () {
          main();
        },
        //icon: Icon(Icons.refresh),
        foregroundColor:Colors.white ,
        backgroundColor:Colors.black ,
        label: Text('Refresh'),
      ),
      //********************
      drawer: MAinDrawer(uid: widget.userId,auth: widget.auth,onSignedOut: widget.onSignedOut),
    );
  }
}
