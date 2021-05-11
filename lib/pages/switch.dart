import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
//import 'package:bar_wow/subscriber_series.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'design.dart';
import '../pages/login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import '../Services/auth.dart';
import '../Services/auth_provider.dart';
import 'package:intl/date_time_patterns.dart';

class SwitchWidget extends StatefulWidget{


  SwitchWidget({Key key, this.auth, this.userId, this.logoutCallback,this.switchID,this.name})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  String switchID;
  String name;




  @override
  SwitchWidgetClass createState() =>  SwitchWidgetClass();


}

class SwitchWidgetClass extends State<SwitchWidget> with AutomaticKeepAliveClientMixin<SwitchWidget>{

  //final String uid;
  //SwitchWidgetClass({this.uid});
  @override
  bool get wantKeepAlive=> true;


  //final CollectionReference usercollection= Firestore.instance.collection('users');
  final databasereference2=FirebaseDatabase.instance.reference();

  bool switchControl = false;
  var textHolder ;
  var x;

  //var idx=UniqueKey();

  final FirebaseAuth _auth=FirebaseAuth.instance;
  DateTime today = new DateTime.now();
  @override
  void initState() {
    super.initState();
    databasereference2
        .child('users')
        .child(widget.userId)
        .child('Live Status').child(widget.name)
        .onValue
        .listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        x=snapshot.value[widget.switchID];
        if(x=='on')
        {
          switchControl=true;
        }
        else
        {
          switchControl=false;
        }
      });
      print(x);
    });
    //print(widget.userId);
  }






  void toggleSwitch(bool value)async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    /* String v=idx.toString();
    v=v.replaceAll("#", "1");
    v=v.replaceAll("[", "c");
    v=v.replaceAll("]", "c");
    print(v);*/




    final username=user.email;
    var currDt = DateTime.now();
    //var today = new DateTime.now();
    print(uid);
    //final reference= Firestore.instance.document(uid);
    databasereference2.child('users').child(uid).child('Live Status').child(widget.name).onValue.listen((event){
      var snapshot=event.snapshot;
      x=snapshot.value[widget.switchID];
      if(x=='on') {
        setState(() {
          switchControl = true;
          //textHolder = idx;
        });
      }
      else
      {
        setState(() {
          switchControl=false;
          //textHolder=idx;
        });
      }
    });

    if (switchControl == false) {
      setState(() {
        switchControl = true;
        //textHolder = idx;
      });
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).child(widget.name).push().set({'state': 'on','switch id':widget.switchID,'time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child(widget.name).child(widget.switchID).set('on');


      //return await usercollection.document(uid).setData({'state': 'on'});


      //return await databasereference2.child('users').child(uid).set({'user name':username});


    }
    else {
      setState(() {
        switchControl = false;
        //textHolder = idx;
      });
      //print('Switch is OFF');
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).child(widget.name).push().set({'state': 'on','switch id':widget.switchID,'time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child(widget.name).child(widget.switchID).set('off');

      //return await usercollection.document(uid).setData({'state': 'off'});
      //return await databasereference2.child('users').child(uid).update({'state': 'off','user':username});


    }
    //final databasereference22=FirebaseDatabase.instance.reference();



  }
  @override

  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Transform.scale(
              scale: 2,
              child: Switch(
                onChanged: toggleSwitch,
                value: switchControl,
                activeColor: Colors.white,
                activeTrackColor: Colors.lightGreen,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.deepOrange,





              )
          ),

          //Text('$idx', style: TextStyle(fontSize: 24),)

        ]

    );
  }




}
class SwitchWidget3 extends StatefulWidget {

  @override
  SwitchWidget3Class createState() => new SwitchWidget3Class();

}

class SwitchWidget3Class extends State {
  //final String uid;
  //SwitchWidgetClass({this.uid});


  //final CollectionReference usercollection= Firestore.instance.collection('users');
  final databasereference2=FirebaseDatabase.instance.reference();

  bool switchControl = false;
  var textHolder = 'Switch is OFF';
  var x;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  DateTime today = new DateTime.now();


  void toggleSwitch(bool value)async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final username=user.email;
    var currDt = DateTime.now();
    //var today = new DateTime.now();
    print(uid);
    //final reference= Firestore.instance.document(uid);
    databasereference2.child('users').child(uid).child('Live Status').child('bed room').onValue.listen((event){
      var snapshot=event.snapshot;
      x=snapshot.value['fan'];
      if(x=='on') {
        setState(() {
          switchControl = true;
          textHolder = "On";
        });
      }
      else
      {
        setState(() {
          switchControl=false;
          textHolder="Off";
        });
      }
    });

    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'On';
      });
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).push().set({'state': 'on','switch id':'fan','time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child('bed room').child('fan').set('on');


      //return await usercollection.document(uid).setData({'state': 'on'});


      //return await databasereference2.child('users').child(uid).set({'user name':username});


    }
    else {
      setState(() {
        switchControl = false;
        textHolder = 'Off';
      });
      //print('Switch is OFF');
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).push().set({'state': 'on','switch id':'fan','time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child('bed room').child('fan').set('off');

      //return await usercollection.document(uid).setData({'state': 'off'});
      //return await databasereference2.child('users').child(uid).update({'state': 'off','user':username});


    }
    //final databasereference22=FirebaseDatabase.instance.reference();



  }
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Transform.scale(
            scale: 2.5,
            child: Switch(
              onChanged: toggleSwitch,
              value: switchControl,
              activeColor: Colors.white,
              activeTrackColor: Colors.green,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.red,





            )
        ),

          //Text('$textHolder', style: TextStyle(fontSize: 24),)

        ]);
  }



}





/*

class SwitchWidget2 extends StatefulWidget {

  @override
  SwitchWidget2Class createState() => new SwitchWidget2Class();

}

class SwitchWidget2Class extends State {
  //final String uid;
  //SwitchWidgetClass({this.uid});


  //final CollectionReference usercollection= Firestore.instance.collection('users');
  final databasereference2=FirebaseDatabase.instance.reference();

  bool switchControl = false;
  var textHolder = 'Switch is OFF';
  var x;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  DateTime today = new DateTime.now();


  void toggleSwitch(bool value)async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final username=user.email;
    var currDt = DateTime.now();
    //var today = new DateTime.now();
    print(uid);
    //final reference= Firestore.instance.document(uid);
    databasereference2.child('users').child(uid).child('Live Status').child('bedroom').onValue.listen((event){
      var snapshot=event.snapshot;
      x=snapshot.value['bed fan'];
      if(x=='on') {
        setState(() {
          switchControl = true;
          textHolder = "On";
        });
      }
      else
      {
        setState(() {
          switchControl=false;
          textHolder="Off";
        });
      }
    });

    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'On';
      });
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).push().set({'state': 'on','switch id':'bed fan','time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child('bedroom').child('bed fan').set('on');


      //return await usercollection.document(uid).setData({'state': 'on'});


      //return await databasereference2.child('users').child(uid).set({'user name':username});


    }
    else {
      setState(() {
        switchControl = false;
        textHolder = 'Off';
      });
      //print('Switch is OFF');
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).push().set({'state': 'on','switch id':'bed bulb','time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child('bedroom').child('bed bulb').set('off');

      //return await usercollection.document(uid).setData({'state': 'off'});
      //return await databasereference2.child('users').child(uid).update({'state': 'off','user':username});


    }
    //final databasereference22=FirebaseDatabase.instance.reference();



  }
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Transform.scale(
            scale: 2.5,
            child: Switch(
              onChanged: toggleSwitch,
              value: switchControl,
              activeColor: Colors.white,
              activeTrackColor: Colors.green,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.red,




            )
        ),

          //Text('$textHolder', style: TextStyle(fontSize: 24),)

        ]);
  }



}
class SwitchWidget4 extends StatefulWidget {

  @override
  SwitchWidget4Class createState() => new SwitchWidget4Class();

}

class SwitchWidget4Class extends State {
  //final String uid;
  //SwitchWidgetClass({this.uid});


  //final CollectionReference usercollection= Firestore.instance.collection('users');
  final databasereference2=FirebaseDatabase.instance.reference();

  bool switchControl = false;
  var textHolder = 'Switch is OFF';
  var x;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  DateTime today = new DateTime.now();


  void toggleSwitch(bool value)async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final username=user.email;
    var currDt = DateTime.now();
    //var today = new DateTime.now();
    print(uid);
    //final reference= Firestore.instance.document(uid);
    databasereference2.child('users').child(uid).child('Live Status').child('kitchen').onValue.listen((event){
      var snapshot=event.snapshot;
      x=snapshot.value['kitch bulb'];
      if(x=='on') {
        setState(() {
          switchControl = true;
          textHolder = "On";
        });
      }
      else
      {
        setState(() {
          switchControl=false;
          textHolder="Off";
        });
      }
    });

    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'On';
      });
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).push().set({'state': 'on','switch id':'kitch bulb','time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child('kitchen').child('kitch bulb').set('on');


      //return await usercollection.document(uid).setData({'state': 'on'});


      //return await databasereference2.child('users').child(uid).set({'user name':username});


    }
    else {
      setState(() {
        switchControl = false;
        textHolder = 'Off';
      });
      //print('Switch is OFF');
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).push().set({'state': 'on','switch id':'kitch bulb','time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child('kitche').child('kitch bulb').set('off');

      //return await usercollection.document(uid).setData({'state': 'off'});
      //return await databasereference2.child('users').child(uid).update({'state': 'off','user':username});


    }
    //final databasereference22=FirebaseDatabase.instance.reference();



  }
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Transform.scale(
            scale: 2.5,
            child: Switch(
              onChanged: toggleSwitch,
              value: switchControl,
              activeColor: Colors.white,
              activeTrackColor: Colors.green,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.red,





            )
        ),

          //Text('$textHolder', style: TextStyle(fontSize: 24),)

        ]);

  }



}
class SwitchWidget5 extends StatefulWidget {

  @override
  SwitchWidget5Class createState() => new SwitchWidget5Class();

}

class SwitchWidget5Class extends State {
  //final String uid;
  //SwitchWidgetClass({this.uid});


  //final CollectionReference usercollection= Firestore.instance.collection('users');
  final databasereference2=FirebaseDatabase.instance.reference();

  bool switchControl = false;
  var textHolder = 'Switch is OFF';
  var x;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  DateTime today = new DateTime.now();


  void toggleSwitch(bool value)async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final username=user.email;
    var currDt = DateTime.now();
    //var today = new DateTime.now();
    print(uid);
    //final reference= Firestore.instance.document(uid);
    databasereference2.child('users').child(uid).child('Live Status').child('living room').onValue.listen((event){
      var snapshot=event.snapshot;
      x=snapshot.value['LR bulb'];
      if(x=='on') {
        setState(() {
          switchControl = true;
          textHolder = "On";
        });
      }
      else
      {
        setState(() {
          switchControl=false;
          textHolder="Off";
        });
      }
    });

    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'On';
      });
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).push().set({'state': 'on','switch id':'LR bulb','time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child('living room').child('LR bulb').set('on');


      //return await usercollection.document(uid).setData({'state': 'on'});


      //return await databasereference2.child('users').child(uid).set({'user name':username});


    }
    else {
      setState(() {
        switchControl = false;
        textHolder = 'Off';
      });
      //print('Switch is OFF');
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).push().set({'state': 'on','switch id':'LR bulb','time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child('living room').child('LR bulb').set('off');

      //return await usercollection.document(uid).setData({'state': 'off'});
      //return await databasereference2.child('users').child(uid).update({'state': 'off','user':username});


    }
    //final databasereference22=FirebaseDatabase.instance.reference();



  }
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Transform.scale(
            scale: 2.5,
            child: Switch(
              onChanged: toggleSwitch,
              value: switchControl,
              activeColor: Colors.white,
              activeTrackColor: Colors.green,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.red,




            )
        ),

          //Text('$textHolder', style: TextStyle(fontSize: 24),)

        ]);
  }



}
class SwitchWidget6 extends StatefulWidget {

  @override
  SwitchWidget6Class createState() => new SwitchWidget6Class();

}

class SwitchWidget6Class extends State {
  //final String uid;
  //SwitchWidgetClass({this.uid});


  //final CollectionReference usercollection= Firestore.instance.collection('users');
  final databasereference2=FirebaseDatabase.instance.reference();

  bool switchControl = false;
  var textHolder = 'Switch is OFF';
  var x;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  DateTime today = new DateTime.now();


  void toggleSwitch(bool value)async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final username=user.email;
    var currDt = DateTime.now();
    //var today = new DateTime.now();
    print(uid);
    //final reference= Firestore.instance.document(uid);
    databasereference2.child('users').child(uid).child('Live Status').child('living room').onValue.listen((event){
      var snapshot=event.snapshot;
      x=snapshot.value['LR fan'];
      if(x=='on') {
        setState(() {
          switchControl = true;
          textHolder = "On";
        });
      }
      else
      {
        setState(() {
          switchControl=false;
          textHolder="Off";
        });
      }
    });

    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'On';
      });
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).push().set({'state': 'on','switch id':'LR fan','time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child('living room').child('lR fan').set('on');


      //return await usercollection.document(uid).setData({'state': 'on'});


      //return await databasereference2.child('users').child(uid).set({'user name':username});


    }
    else {
      setState(() {
        switchControl = false;
        textHolder = 'Off';
      });
      //print('Switch is OFF');
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).push().set({'state': 'off','switch id':'LR fan','time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child('living room').child('LR fan').set('off');

      //return await usercollection.document(uid).setData({'state': 'off'});
      //return await databasereference2.child('users').child(uid).update({'state': 'off','user':username});


    }
    //final databasereference22=FirebaseDatabase.instance.reference();



  }
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Transform.scale(
            scale: 2.5,
            child: Switch(
              onChanged: toggleSwitch,
              value: switchControl,
              activeColor: Colors.white,
              activeTrackColor: Colors.green,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.red,




            )
        ),

          //Text('$textHolder', style: TextStyle(fontSize: 24),)

        ]);
  }



}
class SwitchWidget7 extends StatefulWidget {

  @override
  SwitchWidget7Class createState() => new SwitchWidget7Class();

}

class SwitchWidget7Class extends State {
  //final String uid;
  //SwitchWidgetClass({this.uid});


  //final CollectionReference usercollection= Firestore.instance.collection('users');
  final databasereference2=FirebaseDatabase.instance.reference();

  bool switchControl = false;
  var textHolder = 'Switch is OFF';
  var x;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  DateTime today = new DateTime.now();


  void toggleSwitch(bool value)async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final username=user.email;
    var currDt = DateTime.now();
    //var today = new DateTime.now();
    print(uid);
    //final reference= Firestore.instance.document(uid);
    databasereference2.child('users').child(uid).child('Live Status').child('living room').onValue.listen((event){
      var snapshot=event.snapshot;
      x=snapshot.value['LR AC'];
      if(x=='on') {
        setState(() {
          switchControl = true;
          textHolder = "On";
        });
      }
      else
      {
        setState(() {
          switchControl=false;
          textHolder="Off";
        });
      }
    });

    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'On';
      });
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).push().set({'state': 'on','switch id':'LR AC','time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child('living room').child('LR AC').set('on');


      //return await usercollection.document(uid).setData({'state': 'on'});


      //return await databasereference2.child('users').child(uid).set({'user name':username});


    }
    else {
      setState(() {
        switchControl = false;
        textHolder = 'Off';
      });
      //print('Switch is OFF');
      databasereference2.child('users').child(uid).child('Activity log').child('2020').child(currDt.month.toString()).child('day'+currDt.day.toString()).push().set({'state': 'on','switch id':'LR AC','time':currDt.hour.toString()+':'+currDt.minute.toString()+':'+currDt.second.toString()});
      databasereference2.child('users').child(uid).child('Live Status').child('living room').child('LR AC').set('off');

      //return await usercollection.document(uid).setData({'state': 'off'});
      //return await databasereference2.child('users').child(uid).update({'state': 'off','user':username});


    }
    //final databasereference22=FirebaseDatabase.instance.reference();



  }
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Transform.scale(
            scale: 2.5,
            child: Switch(
              onChanged: toggleSwitch,
              value: switchControl,
              activeColor: Colors.white,
              activeTrackColor: Colors.green,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.red,




            )
        ),

          //Text('$textHolder', style: TextStyle(fontSize: 24),)

        ]);
  }



}*/




































