import'package:cloud_firestore/cloud_firestore.dart';
import'../pages/home_page.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference users= Firestore.instance.collection("user1");
  Future updateuserdata(bool switchControl)async
  { if(switchControl)
    return await users.document(uid).setData({
    'state':'on'
    });


  }
}