import 'package:cloud_firestore/cloud_firestore.dart';

class comment{
String postId;
String commentId;
String username;
String useruid;
String profilepicture;
String text;
DateTime date;

comment({required this.postId,required this.commentId,required this.username,required this.useruid,required this.profilepicture,required this.date,required this.text});

comment.fromjoson(Map<String,dynamic> snapshot):this(
postId:snapshot["postId"] ??'',
commentId: snapshot["commentId"],
username: snapshot["username"],
useruid: snapshot["useruid"],
date: (snapshot["date"] as Timestamp).toDate() ,
profilepicture: snapshot["profilepicture"],
  text:snapshot["text"],

);

Map<String,dynamic>tojoson(){

  return{
    "postId": postId,
    "commentId": commentId,
    "username": username,
    "useruid": useruid,
    "date": date,
    "profilepicture": profilepicture,
    "text": text,

  };
}


}