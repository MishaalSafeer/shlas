import 'dart:async';
import 'package:auth/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Services/database.dart';
import 'package:auth/global.dart'as globals;

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();

}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;




  @override
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    final FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user?.uid;



  }

  @override
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    final FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return user?.uid;


    //await DatabaseService(uid:user.uid).updateuserdata(state)
  }

  @override
  Future<String> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return user?.uid;

  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
