import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_insta/models/my-user.dart';

import '../../database/database-utils.dart';
import '../../models/my_post.dart';
import '../../widget/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  MyUser myUser;
  ProfileScreen(this.myUser);


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int postlength=0;
  bool isFollowing = false;
  int followers = 0;
  int following = 0;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    try{
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.myUser.uid)
          .get();

      setState(() {
        isFollowing=widget.myUser.followers.contains(FirebaseAuth.instance.currentUser!.uid);
        postlength = postSnap.docs.length;
        followers = widget.myUser.followers.length;
        following = widget.myUser.following.length;
      });

    }catch(e){
      print(e.toString());
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.myUser.username),
        centerTitle: false,
      ),
      body: Column(
        children: [
       Row(
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               children: [
                 CircleAvatar(
                   radius: 30,
                   backgroundImage: NetworkImage(widget.myUser.photoUrl),
                 ),
                 SizedBox(height: 5,),
                 Text(widget.myUser.username,style: TextStyle(fontSize: 15,color: Colors.white)),
                 SizedBox(height: 5,),
                 Text(widget.myUser.bio,style: TextStyle(fontSize: 15,color: Colors.white))
               ],
             ),
           ),
           SizedBox(width: 10,),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               children: [
                Text('${postlength.toString()}',style: TextStyle(fontSize: 15,color: Colors.white)),
                SizedBox(height: 5,),
                Text('posts',style: TextStyle(fontSize: 15,color: Colors.white))

               ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               children: [
                 Text('${widget.myUser.followers.length}',style: TextStyle(fontSize: 15,color: Colors.white)),
                 SizedBox(height: 5,),
                 Text('followers',style: TextStyle(fontSize: 15,color: Colors.white))

               ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               children: [
                 Text('${widget.myUser.following.length}',style: TextStyle(fontSize: 15,color: Colors.white)),
                 SizedBox(height: 5,),
                 Text('following',style: TextStyle(fontSize: 15,color: Colors.white))

               ],
             ),
           )

         ],

       )  ,
          SizedBox(height: 10,),

          isFollowing
              ? FollowButton(
            text: 'Unfollow',
            backgroundColor: Colors.white,
            textColor: Colors.black,
            borderColor: Colors.grey,
            function: () async {
              await DatabaseUtils
                  .followUser(
                FirebaseAuth.instance
                    .currentUser!.uid,
               widget.myUser.uid,
                widget.myUser.following
              );

              setState(() {
                isFollowing = false;
                followers--;
              });
            },
          )
              : FollowButton(
            text: 'Follow',
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            borderColor: Colors.blue,
            function: () async {
              await  DatabaseUtils
                  .followUser(
                FirebaseAuth.instance
                    .currentUser!.uid,
                widget.myUser.uid,
                widget.myUser.following
              );

              setState(() {
                isFollowing = true;
                followers++;
              });
            },
          ),



          Divider(),
          Expanded(child: StreamBuilder<QuerySnapshot<post>>(
              stream: DatabaseUtils.getpost(widget.myUser.uid),
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );}
                if(snapshot.hasError){

                  return Center(child: Text('some error accourdd'));

                }
                var postsList=snapshot.data?.docs.map((posts) =>posts.data() ).toList();
                return Container(
                  height: 200,
                  child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: postsList?.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 1.5,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {


                            return Container(
                              child: Image(
                                image: NetworkImage(postsList![index].postUrl),
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        )

                )  ;


              }





          ))



        ],
      ),



    );
  }
}
