import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_insta/database/database-utils.dart';

import 'package:new_insta/models/my_comment.dart';
import 'package:new_insta/models/my_post.dart';
import 'package:new_insta/provider/user-provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'commentcard.dart';

class CommentScreen extends StatefulWidget {
  post pos;
  CommentScreen(this.pos);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  var textcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    printpostId();
    UserProvider userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('comment_screen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
         Expanded(child: StreamBuilder<QuerySnapshot<comment>>(
           stream: DatabaseUtils.getcomment(widget.pos.postId),
           builder: (context,snapshot){
             if(snapshot.connectionState==ConnectionState.waiting){

               return CircularProgressIndicator();
             }

             if(snapshot.hasError){

               return Center(child: Text('${snapshot.error}'));

             }
             var commentList=snapshot.data?.docs.map((com)=>com.data()).toList();

          return  ListView.builder(
                itemCount: commentList?.length,
                itemBuilder: (context,index){

             return CommentCard(commentList![index]) ;
            });


           },



         ))


        ],
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userProvider.myUser!.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: textcontroller,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${userProvider.myUser?.username}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  postcomment();
                  cleartext();
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }

  cleartext(){
    textcontroller.clear();

  }

  postcomment()async{
    UserProvider userProvider=Provider.of<UserProvider>(context,listen: false);
    var vv1 = const Uuid();
    comment com=comment(postId: widget.pos.postId, commentId: vv1.v1(), username: userProvider.myUser!.username, useruid: userProvider.myUser!.uid, profilepicture: userProvider.myUser!.photoUrl, date: DateTime.now(),text: textcontroller.text);
    await  DatabaseUtils.Createcomment(com);

  }

  printpostId(){
    print('   my post id is ${widget.pos.postId}');
  }
}
