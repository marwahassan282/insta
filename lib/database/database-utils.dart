
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/my-user.dart';
import '../models/my_comment.dart';
import '../models/my_post.dart';


class DatabaseUtils{

 static CollectionReference<MyUser> getUserCollection(){
   return FirebaseFirestore.instance.collection(MyUser.collctionName).withConverter(
        fromFirestore: (snapshot,op)=>MyUser.fromjoson(snapshot.data()!),
        toFirestore: (user,op)=>user.tojoson());



  }
 static CollectionReference<post> getpostCollection(){
  return FirebaseFirestore.instance.collection('posts').withConverter(
      fromFirestore: (snapshot,op)=>post.fromjoson(snapshot.data()!),
      toFirestore: (post,op)=>post.tojoson());



 }
 static CollectionReference<comment> getcommentCollection(){
  return FirebaseFirestore.instance.collection('comments').withConverter(
      fromFirestore: (snapshot,op)=>comment.fromjoson(snapshot.data()!),
      toFirestore: (comment,op)=>comment.tojoson());



 }





 static Future<void>CreateDbUser(MyUser user){

  return getUserCollection().doc(user.uid).set(user);
 }

 static Future<void>Createcomment(comment comment){

  return getcommentCollection().doc(comment.commentId).set(comment);
 }
 static Future<void>Createpost(post pos){

  return getpostCollection().doc(pos.postId).set(pos);
 }







 static Future<MyUser?> readuser(String userId) async{


  var userSnapShot= await getUserCollection().doc(userId).get();
  return userSnapShot.data();
 }

 static Stream<QuerySnapshot<MyUser>> searchforuser(String username){


   var searchuser=  getUserCollection().where('username',isGreaterThanOrEqualTo: username,).snapshots();
   return searchuser;
 }
 static  Stream<QuerySnapshot<post>> getpost(String ? userId){
  return  getpostCollection().where('uid', isEqualTo:userId ).snapshots();
 }
 static  Stream<QuerySnapshot<comment>> getcomment(String postId){
  return getcommentCollection().where('postId', isEqualTo:postId, ).snapshots();
 }
 static  Future<void> deletepost(String postId){
  return  getpostCollection().doc(postId).delete();
 }
static Future<void>  likePost(String postId, String uid, List likes) async {


   if (likes.contains(uid)) {
    // if the likes list contains the user uid, we need to remove it
   return getpostCollection().doc(postId).update({
     'likes': FieldValue.arrayRemove([uid])
    });
   } else {

  return getpostCollection().doc(postId).update({
     'likes': FieldValue.arrayUnion([uid])
    });






}}
static Future<void> followUser(
     String uid,
     String followId,
    List following
     ) async {
   try {


     if(following.contains(followId)) {
       await getUserCollection().doc(followId).update({
         'followers': FieldValue.arrayRemove([uid])
       });

       await getUserCollection().doc(uid).update({
         'following': FieldValue.arrayRemove([followId])
       });
     } else {
       await getUserCollection().doc(followId).update({
         'followers': FieldValue.arrayUnion([uid])
       });

       await getUserCollection().doc(uid).update({
         'following': FieldValue.arrayUnion([followId])
       });
     }

   } catch(e) {
     print(e.toString());
   }

 }
 static Future<void>Updateuserdata(MyUser user){

   return getUserCollection().doc(user.uid).update(user.tojoson());

 }


}