
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_insta/database/database-utils.dart';
import 'package:new_insta/layout/profile/profilescreen.dart';
import 'package:new_insta/models/my-user.dart';
import 'package:new_insta/models/my_post.dart';

class SearchScreen extends StatefulWidget {



  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController=TextEditingController();
  bool showuser=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Form(
         child: TextFormField(
           controller:searchController,
           onFieldSubmitted: (value){

             setState(() {
               showuser=true;
             });

           },

           decoration: InputDecoration(
hintText: 'search for user......',
             border: InputBorder.none

           ),

         ),
       ),
       actions: [
         IconButton(
           onPressed: (){},
           icon: Icon(Icons.search),
         )
       ],
     ),

      body: showuser? StreamBuilder<QuerySnapshot<MyUser>>(
        stream: DatabaseUtils.searchforuser(searchController.text),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){


            return Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){

            return Center(child: Text('${snapshot.error}'));
          }
          var listuser=snapshot.data?.docs.map((users) => users.data()).toList();
        return ListView.builder(
            itemCount: listuser?.length,
            itemBuilder: (context,index){

         return InkWell(
           onTap: (){

             Navigator.push(context, MaterialPageRoute(builder: (c){return ProfileScreen(listuser[index]);}));
           },
           child: ListTile(
           leading: CircleAvatar(
             radius: 25,
             backgroundImage: NetworkImage(listuser![index].photoUrl),

           ),

             title: Text('${listuser[index].username}'),
             subtitle: Text('${listuser[index].username}'),


           ),
         ) ;

        }) ;

        },



      ):StreamBuilder<QuerySnapshot<post>>(
        stream: DatabaseUtils.getpostCollection().snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
  var postlists=snapshot.data?.docs.map((posts) => posts.data()).toList();
          return StaggeredGridView.countBuilder(
            crossAxisCount: 3,
            itemCount: postlists?.length,
            itemBuilder: (context, index) => Image.network(
     postlists![index].postUrl,
              fit: BoxFit.cover,
            ),
            staggeredTileBuilder: (index) => StaggeredTile.count(
                (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          );
        },
      ),



    );
  }
}
