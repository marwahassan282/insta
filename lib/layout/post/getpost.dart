import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_insta/database/database-utils.dart';
import 'package:new_insta/layout/post/postcard.dart';
import 'package:new_insta/models/my_post.dart';
import 'package:new_insta/provider/user-provider.dart';
import 'package:provider/provider.dart';

class getPost extends StatelessWidget {
  const getPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
appBar: AppBar(
  title: Text('instagram'),

),
      body: Column(
        children: [
      Expanded(child: StreamBuilder<QuerySnapshot<post>>(
       stream: DatabaseUtils.getpost(userProvider.myUser?.uid),
        builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );}
          if(snapshot.hasError){

            return Center(child: Text('some error accourdd'));

    }
        var messageList=snapshot.data?.docs.map((posts) =>posts.data() ).toList();
        return Container(
          height: 200,
          child: ListView.builder(

              itemCount: messageList?.length,
              itemBuilder: (context,index){
                 return PostCard(messageList![index]);
          }),
        )  ;


        }





      ))


        ],
      ),

    );
  }
}
