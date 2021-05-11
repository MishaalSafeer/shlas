import 'package:auth/main.dart';
import 'package:auth/pages/buttonpage.dart';
import 'package:auth/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'design.dart';
import 'dart:async';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Services/auth.dart';
import '../Services/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Services/auth.dart';
import '../Services/auth_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import '../pages/switch.dart';
import 'package:auth/pages/settings.dart';
import '../pages/home_page.dart' as home;
import 'package:auth/pages/scheduler.dart';
import 'package:auth/global.dart' as globals;

class MAinDrawer extends StatelessWidget {
  MAinDrawer({Key key,this.uid,this.auth,this.onSignedOut}):super(key:key);
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  String uid;
  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
//            color: Theme
//                .of(context)
//                .primaryColor,
            color: Colors.indigo,
            //color: Color(0xFF32323e),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 50,
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
//                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
//                      ),
                  ),
                  Text(
                    "HOME SCREEN",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'WELCOME',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.room),
            title: Text(
              'ADD ROOM',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              print('You Clicked BEDROOM');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => lstviw()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.lock),
            title: Text(
              'LOGOUT',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () => _signOut(context),
          ),


          // ListTile(
          //   leading: Icon(Icons.arrow_back),
          // title: Text(
          // 'LOGOUT',
          //style: TextStyle(
          //fontSize: 18,
          //),
          //)
          //,
          // onTap:()
          //{
          // _signOut(context);
          //},

          //),
        ],
      ),
    );
  }
}

var lightGrey = Color(0xFF414350);
var lightBlue = Color(0xFF5157c2);

var bedRoomImage =
    'https://d4qwptktddc5f.cloudfront.net/mark-zeff-new-york-loft-daughter-bedroom-0418-SPRINGHOMES.jpg';

class bed extends StatefulWidget {
  bed({Key key, this.uid, this.c}) : super(key: key);
  String uid;
  String c;

  @override
  bedd createState() => bedd();
}

class bedd extends State<bed> {
  Timer myTimer;
  final fb = FirebaseDatabase.instance.reference().child("Weather");
  final durr = const Duration(seconds: 3600);
  var yr = "2018";
  var mon = DateTime.now().month.toString();
  var day = DateTime.now().day.toString();
  var hr = DateTime.now().hour;
  var x;
  var x2;
  var x3;
  var x4;
  final databasereference2=FirebaseDatabase.instance.reference();
  List<dynamic> _text;
  String c = 'bedroom';
  void fetchDat(Function perform, {var c = 0}) {
    print('CALLED fetchDat');
    var res = '';
    var res1 = '';
    Map<dynamic, dynamic> vals;
    try {
      var h = (c + hr).toString();
      print(h);
      fb
          .child(yr)
          .child(mon)
          .child(day)
          .child(h)
          .once()
          .then((DataSnapshot snapshot) {
        vals = snapshot.value;
        if (vals != null) {
          res = (vals.values).first['Temp'];
          res1 = (vals.values).first['Visibility'];
          print("The RECEIVED TEMP IS: ${res}");
          print("The RECEIVED VIS IS: ${res1}");
          if (res != null) {
            perform(double.parse(res), double.parse(res1));
          }
        } else {
          print("Vals was NULL");
          fetchDat(perform, c: c - 1);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void decTree() {
    fetchDat(condFan);
    fetchDat(condAC);
    fetchDat(condNightLight);
    fetchDat(condLight);
  }

  void condAC(double temp, double visibility) {
    print('CALLED condAC');
    var time = ((DateTime.now().hour) * 60)+ DateTime.now().minute;
    try {
      setState(() {
        if (temp <= 22.5) {
          //Switch OFF
          x='off';
          databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('309').set('off');

        } else {
          if (time <= 253.7) {
            //Switch ON
            x='on';
            databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('309').set('on');

          } else {
            if (time <= 789.7) {
              //Switch OFF
              x='off';
              databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('309').set('off');
            } else {
              if (time <= 1037) {
                //Switch ON
                x='on';
                databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('309').set('on');
              } else {
                if (time <= 1277.3) {
                  //Switch OFF
                  x='off';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('309').set('off');
                } else {
                  //Switch ON
                  x='on';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('309').set('on');
                }
              }
            }
          }
        }
        print('CHANGED AC');
        //databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set(x);
      });
    } catch (e) {
      print(e);
    }
  }

  void condNightLight(double temp, double visibility) {
    print('CALLED condNightLight');
    var time = ((DateTime.now().hour) * 60) + DateTime.now().minute;
    try {
      setState(() {
        if (time <= 253.94) {
          //Switch ON
          x2='on';
          databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('921').set('on');
        } else {
          if (time <= 1270.52) {
            if (time <= 538.39) {
              if (temp <= 16.50) {
                //Switch ON
                x2='on';
                databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('921').set('on');
              } else {
                //switch OFF
                x2='off';
                databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('921').set('off');
              }
            } else {
              //switch OFF
              x2='off';
              databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('921').set('off');
            }
          } else {
            if (temp <= 17.50) {
              if (time <= 1354.96) {
                if (visibility <= 1012.50) {
                  //Switch ON
                  x2='on';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('921').set('on');
                } else {
                  //switch OFF
                  x2='off';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('921').set('off');
                }
              } else {
                //Switch ON
                x2='on';
                databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('921').set('on');
              }
            } else {
              //Switch ON
              x2='on';
              databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('921').set('on');
            }
          }
        }
        print('CHANGED NIGHTLIGHT');
        //databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set(x2);
      });
    } catch (e) {
      print(e);
    }
  }

  void condLight(double temp, double visibility) {
    print('CALLED condLight');
    var time = ((DateTime.now().hour) * 60) + DateTime.now().minute;
    try {
      setState(() {
        if (time <= 254.68) {
          //switch OFF
          x3='off';
          databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
        } else {
          if (time <= 439.15) {
            if (temp <= 14.50) {
              //switch OFF
              //x3='on';
              databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
            } else {
              if (time <= 309.39) {
                if (visibility <= 1004.50) {
                  if (visibility <= 1000.50) {
                    //Switch ON
                    x3='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                  } else {
                    //Switch ON
                    x3='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                  }
                } else {
                  //switch OFF
                  x3='off';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                }
              } else {
                if (temp <= 16.50) {
                  if (visibility <= 1013.00) {
                    if (time <= 344.08) {
                      //switch OFF
                      x3='off';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                    } else {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                    }
                  } else {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                  }
                } else {
                  //Switch ON
                  x3='on';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                }
              }
            }
          } else {
            if (time <= 1016.29) {
              if (time <= 820.96) {
                if (time <= 570.03) {
                  if (time <= 465.92) {
                    if (temp <= 14.50) {
                      //switch OFF
                      x3='off';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                    } else {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                    }
                  } else {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                  }
                } else {
                  if (time <= 747.37) {
                    if (temp <= 18.50) {
                      //Switch ON
                      x3 = 'on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                    } else {
                      //switch OFF
                      x3='off';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                    }
                  } else {
                    if (visibility <= 1006.50) {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                    } else {
                      //switch OFF
                      x='off';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                    }
                  }
                }
              } else {
                if (time <= 923.14) {
                  if (time <= 832.44) {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                  } else {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                  }
                } else {
                  if (temp <= 24.50) {
                    //Switch ON
                    x3='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                  } else {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                  }
                }
              }
            } else {
              if (time <= 1275.89) {
                if (time <= 1052.58) {
                  if (temp <= 23.50) {
                    //Switch ON
                    x3='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                  } else {
                    if (time <= 1032.33) {
                      //switch OFF
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                    } else {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                    }
                  }
                } else {
                  if (time <= 1273.88) {
                    //Switch ON
                    x3='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                  } else {
                    if (time <= 1275.18) {
                      //switch OFF
                      x3='off';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                    } else {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                    }
                  }
                }
              } else {
                if (temp <= 16.50) {
                  if (time <= 1391.12) {
                    if (temp <= 13.50) {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                    } else {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                    }
                  } else {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                  }
                } else {
                  if (time <= 1293.06) {
                    //Switch ON
                    x3='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('on');
                  } else {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('877').set('off');
                  }
                }
              }
            }
          }
        }
        print('CHANGED LIGHT');
        //databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set(x3);
      });
    } catch (e) {
      print(e);
    }
  }

  void condFan(double temp, double visibility) {
    print('CALLED condFan');
    var time = ((DateTime.now().hour) * 60)+ DateTime.now().minute;
    try {
      setState(() {
        if (temp <= 21.50) {
          //switch OFF
          x4='off';
          databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('899').set('off');
        } else {
          if (time <= 254.52) {
            //switch OFF
            x4='off';
            databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('899').set('off');
          } else {
            if (time <= 433.95) {
              if (time <= 259.73) {
                //switch OFF
                x4='off';
                databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('899').set('off');
              } else {
                //Switch ON
                x4='on';
                databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('899').set('on');
              }
            } else {
              if (time <= 734.91) {
                if (time <= 462.11) {
                  //Switch ON
                  x4='on'; databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('899').set('on');
                } else {
                  //switch OFF
                  x4='off';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('899').set('off');
                }
              } else {
                if (time <= 820.87) {
                  if (time <= 745.93) {
                    //switch OFF
                    x4='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('899').set('off');
                  } else {
                    //Switch ON
                    x4='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('899').set('on');
                  }
                } else {
                  if (time <= 1037.24) {
                    //switch OFF
                    x4='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('899').set('off');
                  } else {
                    //Switch ON
                    x4='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.c).child('899').set('on');
                  }
                }
              }
            }
          }
          print('CHANGED FAN');
          //databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set(x4);
        }
      });
    } catch (e) {
      print(e);
    }
  }
  void startTimer() {
    decTree();
    myTimer = Timer.periodic(durr, (Timer t) => decTree());
  }
  @override
  void dispose() {
    myTimer?.cancel();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _text = new List();
    databasereference2
        .child('users')
        .child(widget.uid)
        .child('Switches')
        .child(widget.c)
        .onChildAdded
        .listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        _text.add(snapshot.value['switch']);
      });
      print(_text);
    });
    //print(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.uid);
    print(_text);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.c,
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
              child: Text(' ADD SWITCH',
                  style: TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DropdownExample(uid: widget.uid, name: widget.c)));
              })
        ], //title: Text('Example'),
      ),
      body: SingleChildScrollView(
          child: new Column(children: <Widget>[
            new Container(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          offset: Offset(-3, -3),
                          color: Colors.white.withOpacity(.7)),
                      BoxShadow(
                          blurRadius: 5.0,
                          offset: Offset(3, 3),
                          color: Colors.black.withOpacity(.15))
                    ]),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            if (_text.contains('AC1'))
              new Container(
                child: Container(
                  height: 105.0,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(-5, -5),
                            color: Colors.blue.withOpacity(1)),
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(3, 3),
                            color: Colors.white.withOpacity(.2))
                      ]),
                  child: Column(

                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('AC1',textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,height: 1.6,
                          fontWeight: FontWeight.bold,
                        ),),
                      Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 0, left: 0),

                        child: SwitchWidget(
                            userId: widget.uid, switchID: '309', name: widget.c),
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(
              height: 20.0,
            ),
            if (_text.contains('TubeLight'))
              new Container(
                child: Container(
                  height: 105.0,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(-5, -5),
                            color: Colors.blue.withOpacity(1.0)),
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(3, 3),
                            color: Colors.white.withOpacity(.2))
                      ]),
                  child: Column(

                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('TUBE LIGHT',textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,height: 1.6,
                          fontWeight: FontWeight.bold,
                        ),),
                      Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 0, left: 0),

                        child: SwitchWidget(
                            userId: widget.uid, switchID: '500', name: widget.c),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 20.0,
            ),
            if (_text.contains('AC1.5'))
              new Container(
                child: Container(
                  height: 105.0,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(-5, -5),
                            color: Colors.blue.withOpacity(1.0)),
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(3, 3),
                            color: Colors.white.withOpacity(.2))
                      ]),
                  child: Column(

                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('AC 1.5',textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,height: 1.6,
                          fontWeight: FontWeight.bold,
                        ),),
                      Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 0, left: 0),

                        child: SwitchWidget(
                            userId: widget.uid, switchID: '309', name: widget.c),
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(
              height: 20.0,
            ),
            if (_text.contains('ES Bulb'))
              new Container(
                child: Container(
                  height: 105.0,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(-5, -5),
                            color: Colors.blue.withOpacity(1.0)),
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(3, 3),
                            color: Colors.white.withOpacity(.2))
                      ]),
                  child: Column(

                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('BULB',textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,height: 1.6,
                          fontWeight: FontWeight.bold,
                        ),),
                      Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 0, left: 0),

                        child: SwitchWidget(
                            userId: widget.uid, switchID: '877', name: widget.c),
                      ),
                    ],
                  ),
                ),
              ),


            SizedBox(
              height: 20.0,
            ),

            if (_text.contains('CFan'))
              new Container(
                child: Container(
                  height: 105.0,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(-5, -5),
                            color: Colors.blue.withOpacity(1)),
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(3, 3),
                            color: Colors.white.withOpacity(.2))
                      ]),
                  child: Column(

                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('FAN',textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,height: 1.6,
                          fontWeight: FontWeight.bold,
                        ),),
                      Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 0, left: 0),

                        child: SwitchWidget(
                            userId: widget.uid, switchID: '899', name: widget.c),
                      ),
                    ],
                  ),
                ),
              ),


            SizedBox(
              height: 20.0,
            ),

            if (_text.contains('NL'))
              new Container(
                child: Container(
                  height: 105.0,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(-5, -5),
                            color: Colors.blue.withOpacity(1)),
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(3, 3),
                            color: Colors.white.withOpacity(.2))
                      ]),
                  child: Column(

                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('NIGHT LIGHT',textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,height: 1.6,
                          fontWeight: FontWeight.bold,
                        ),),
                      Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 0, left: 0),

                        child: SwitchWidget(
                            userId: widget.uid, switchID: '921', name: widget.c),
                      ),
                    ],
                  ),
                ),
              ),


            SizedBox(
              height: 20.0,
            ),
          ])),
      floatingActionButton: FloatingActionButton.extended(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue.withOpacity(0.39),



          //splashColor: Colors.green,
          onPressed: () {
            startTimer();
          },
          //icon:Icon(Icons.launch),
          label:Text('Implement Schedule',style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            //height: 2,
            fontWeight: FontWeight.bold,
          ),)
      ),
    );
  }
}
