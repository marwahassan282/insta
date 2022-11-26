
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../addtodatabase/Storge_Methodes.dart';
import '../addtodatabase/addpost.dart';
import '../base.dart';
import '../database/database-utils.dart';
import '../models/my-user.dart';
import 'Navigator.dart';

class RegisterViewModel extends BaseViewModel <RegisterNavigator>{
String ? message;
FirebaseAuth firebaseAuth=FirebaseAuth.instance;
   CreateAccount(String username,String password, Uint8List photoUrl,String email,String bio,List followers,List following,context) async{


  try {
  navigator.showloading('loading....',false);
    final credential =   await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  String photo=  await StorgeMethods().uploadImageToFireStorge('profilepicture',photoUrl, false);
    MyUser user=MyUser(uid: firebaseAuth.currentUser?.uid??'', username:username, photoUrl: photo, email:email, bio: bio, followers: followers, following: following);
  var result =DatabaseUtils.CreateDbUser(user);
  navigator.hideloading();
  Navigator.push(context, MaterialPageRoute(builder: (c){
    return addPost();
  }));





  }
  on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      message='The password provided is too weak.';


    } else if (e.code == 'email-already-in-use') {
      message='The account already exists for that email.';


    }
    navigator.hideloading();
    if(message!=null){
      navigator.showmessage(message!);
    }
  } catch (e) {
    print(e);
  }

}



}