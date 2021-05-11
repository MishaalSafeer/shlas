import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/global.dart'as g;
import '../Services/auth.dart';


class DropdownExample extends StatefulWidget {

  DropdownExample({Key key, this.uid,this.name}) : super(key: key);
  String uid;
  String name;
  @override
  _DropdownExampleState createState() {
    return _DropdownExampleState();
  }
}

class _DropdownExampleState extends State<DropdownExample> with AutomaticKeepAliveClientMixin {

  String _value;
  List<dynamic> _v;

  var i;


  final databasereference2 = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'SETTINGS',
            style: TextStyle(
                fontSize: 35,
                height: 1.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo,

        ),
        body: Container(

          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("image/switch2.jpeg"),
                fit: BoxFit.fill
            ),
          ),

          child: new Column(


              children: <Widget>[
                SizedBox(height: 100),
                Center(

                  child: DropdownButton<String>(

                    items: [
                      DropdownMenuItem<String>(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.highlight),
                            SizedBox(width: 10),
                            Text(
                              "TUBE LIGHT", style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ],
                        ),
                        value: 'TubeLight',
                      ),
                      DropdownMenuItem<String>(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.lightbulb_outline),
                            SizedBox(width: 10),
                            Text(
                              "ENERGY SAVER BULB", style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ],
                        ),

                        value: 'ES Bulb',
                      ),
                      DropdownMenuItem<String>(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.ac_unit),
                            SizedBox(width: 10),
                            Text(
                              "CEILING FAN", style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ],
                        ),


                        value: 'CFan',
                      ),

                      DropdownMenuItem<String>(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.ac_unit),
                            SizedBox(width: 10),
                            Text(
                              "AC 1TON", style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ],
                        ),


                        value: 'AC1',
                      ),
                      DropdownMenuItem<String>(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.ac_unit),
                            SizedBox(width: 10),
                            Text(
                              "AC 1.5TON", style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ],
                        ),

                        value: 'AC1.5',
                      ),
                      DropdownMenuItem<String>(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.lightbulb_outline),
                            SizedBox(width: 10),
                            Text(
                              "NIGHT LIGHT", style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ],
                        ),
                        value: 'NL',
                      ),
                    ],
                    onChanged: (String value) {
                      _v = new List();
                      setState(() {
                        _value = value;
                        _v.add(_value);

                        databasereference2.child('users').child(widget.uid)
                            .child('Switches').child(widget.name).push()
                            .set({'switch': _value});
                      });
                      print(_v);
                    },

                    hint: Text(
                      "ADD SWITCHES",
                      style: TextStyle(
                          color: Colors.white, fontSize: 35,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    // hint: Text('Select Item'),
                    value: _value,


                  ),
                ),
              ]
          ),
        )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}