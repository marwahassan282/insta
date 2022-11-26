import 'package:cloud_firestore/cloud_firestore.dart';

class post{

  final String description;
  final String uid;
  final String username;
  final  List likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  post({

    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
});
  post.fromjoson(Map<String,dynamic> snapshot):this(
      description: snapshot["description"],
      uid: snapshot["uid"],
      likes: snapshot["likes"],
      postId: snapshot["postId"],
      datePublished: (snapshot["datePublished"] as Timestamp).toDate() ,
      username: snapshot["username"],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage']
  );

  Map<String,dynamic>tojoson(){

    return{
      "description": description,
      "uid": uid,
      "likes": likes,
      "username": username,
      "postId": postId,
      "datePublished": datePublished,
      'postUrl': postUrl,
      'profImage': profImage

    };
  }






}