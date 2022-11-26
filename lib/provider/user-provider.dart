
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../database/database-utils.dart';
import '../models/my-user.dart';

class UserProvider extends ChangeNotifier{
 MyUser?  myUser;
User ? Firebaseuser;

UserProvider(){
  Firebaseuser=FirebaseAuth.instance.currentUser;
  initmyuser();

}
 initmyuser()async{
  if(Firebaseuser!=null)
  myUser=await  DatabaseUtils.readuser(Firebaseuser!.uid) ;
  notifyListeners();
}

}