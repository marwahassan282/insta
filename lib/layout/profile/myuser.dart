
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_insta/provider/user-provider.dart';
import 'package:provider/provider.dart';

import '../../database/database-utils.dart';
import '../../models/my_post.dart';
import '../../widget/follow_button.dart';
import 'editprofile.dart';

class myuserScreen extends StatefulWidget {
int postlength=0;


  @override
  State<myuserScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<myuserScreen> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
getdata() async {
  UserProvider userProvider=Provider.of<UserProvider>(context,listen: false);
  try{
    var postSnap = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo:FirebaseAuth.instance.currentUser?.uid)
        .get();
    widget.postlength = postSnap.docs.length;
    setState(() {

    });

  }catch(e){
    print(e.toString());
  }

}

  @override
  Widget build(BuildContext context) {

    UserProvider userProvider=Provider.of<UserProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text(userProvider.myUser!.username),
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
                      backgroundImage: NetworkImage(userProvider.myUser!.photoUrl),
                    ),
                    SizedBox(height: 5,),
                    Text(userProvider.myUser!.username,style: TextStyle(fontSize: 15,color: Colors.white)),
                    SizedBox(height: 5,),
                    Text(userProvider.myUser!.bio,style: TextStyle(fontSize: 15,color: Colors.white))
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('${widget.postlength.toString()}',style: TextStyle(fontSize: 15,color: Colors.white)),
                    SizedBox(height: 5,),
                    Text('posts',style: TextStyle(fontSize: 15,color: Colors.white))

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('${userProvider.myUser?.followers.length}',style: TextStyle(fontSize: 15,color: Colors.white)),
                    SizedBox(height: 5,),
                    Text('followers',style: TextStyle(fontSize: 15,color: Colors.white))

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('${userProvider.myUser?.following.length}',style: TextStyle(fontSize: 15,color: Colors.white)),
                    SizedBox(height: 5,),
                    Text('following',style: TextStyle(fontSize: 15,color: Colors.white))

                  ],
                ),
              )

            ],

          )  ,
          SizedBox(height: 10,),

          FollowButton(
            text: 'Edit profile',
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            borderColor: Colors.blue,
            function: ()  {
Navigator.push(context, MaterialPageRoute(builder: (c){

  return EditProfileUser();
}));


              }),





          Divider(),
          Expanded(child: StreamBuilder<QuerySnapshot<post>>(
              stream: DatabaseUtils.getpost(FirebaseAuth.instance.currentUser?.uid),
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