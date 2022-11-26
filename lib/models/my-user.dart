import 'dart:typed_data';

class MyUser{
  final String email;
  final String uid;
  final String  photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;
static const collctionName='user';
MyUser({ required this.username,
  required this.uid,
  required this.photoUrl,
  required this.email,
  required this.bio,
  required this.followers,
  required this.following});

MyUser.fromjoson(Map<String,dynamic> snapshot):this(
  username: snapshot["username"],
  uid: snapshot["uid"],
  email: snapshot["email"],
  photoUrl: snapshot["photoUrl"],
  bio: snapshot["bio"],
  followers: snapshot["followers"],
  following: snapshot["following"],
);

 Map<String,dynamic>tojoson(){

   return{
     "username": username,
     "uid": uid,
     "email": email,
     "photoUrl": photoUrl,
     "bio": bio,
     "followers": followers,
     "following": following,


   };
 }





}