import 'package:auth/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:auth/global.dart' as globals;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/pages/root_page.dart';



class lstviw extends StatefulWidget {

  @override
  _State createState() => _State();


}

class _State extends State<lstviw> {

  final databasereference2=FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  String uid;
  var text=new List();


  TextEditingController nameController = TextEditingController();
  var i=0;

  void addItemToList()async{
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
    text.add(nameController.text);
    //print('the array':globals.$idx);
    databasereference2.child('users').child(uid).child('rooms').push().set({'room': nameController.text});
  }

  /*setState(() {
      text.add(nameController.text);
      //print('the array':globals.$idx);
      databasereference2.child(uid).child('rooms').push().set({'room':nameController.text});
      //i=i+1;

    });*/

  // @override
  /*void initState() {
    super.initState();
    /*final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;*/
    setState(() {
      text.add(nameController.text);
      //print('the array':globals.$idx);
      databasereference2.child(uid).child('rooms').push().set({'room':nameController.text});});
    }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ADD ROOM', style: TextStyle(
              fontSize: 35,
              height: 1.0,
              fontWeight: FontWeight.bold,
              color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          //title: Text('Example'),
        ),
        body: Column(
            children: <Widget>[

              Padding(
                  padding: EdgeInsets.fromLTRB(30,100,40,50),
                  child:Text(
                    "ENTER NEW ROOM",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green,fontSize: 28,),
                  )
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50,5,40,50),
                child: TextFormField(
                  key:Key('text'),
                  style: TextStyle(color: Colors.white),
                  controller: nameController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color:Colors.green,width: 3.0),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color:Colors.blueAccent,width:0.0),
                    ),
                    enabledBorder:const OutlineInputBorder(
                      borderSide: const BorderSide(color:Colors.green,width:0.0),
                    ) ,

                    border: OutlineInputBorder(),

                    labelText: 'ENTER HERE',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.normal,
                        color: Colors.blueAccent, fontSize: 25),
                    fillColor: Colors.white,
                  ),
                ),
              ),

              RaisedButton(
                child: Text('ADD',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 30,)),
                color: Colors.blue.withOpacity(0.4),
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                splashColor: Colors.grey,
                onPressed: () {
                  addItemToList();

                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),



//              Expanded(
//                  child: ListView.builder(
//                      padding: const EdgeInsets.all(8),
//                      itemCount: text.length,
//                      itemBuilder: (BuildContext context, int index) {
//                        return Container(
//                          height: 50,
//                          margin: EdgeInsets.all(2),
//                          color: Colors.blueAccent,
//                          child: Center(
//                              child: Text('${text[index]}',
//                                style: TextStyle(fontSize: 18,color: Colors.white),
//
//                              )
//                          ),
//                        );
//                      }
//                  )
//              )
            ]
        )
    );
  }
}