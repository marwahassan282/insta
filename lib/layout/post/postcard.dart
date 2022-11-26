import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_insta/database/database-utils.dart';
import 'package:provider/provider.dart';

import '../../models/my_post.dart';
import '../../provider/user-provider.dart';
import '../comment_screen/commentScreen.dart';

class PostCard extends StatelessWidget {
  post posts;
  PostCard(this.posts);


  @override
  Widget build(BuildContext context) {
    UserProvider userProvider=Provider.of<UserProvider>(context);
    return  Container(
       child: Column(
         children: [
           SizedBox(height: 10,),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               children: [
                 CircleAvatar(
                   radius: 24,
                   backgroundImage: NetworkImage(posts.profImage),

                 ),
                 SizedBox(width: 12,),
                 Text('${posts.username}',style: Theme.of(context).textTheme.subtitle1),
                 Spacer(),
                 IconButton(
                   onPressed: () {
                     showDialog(
                       useRootNavigator: false,
                       context: context,
                       builder: (context) {
                         return Dialog(
                           child: ListView(
                               padding: const EdgeInsets.symmetric(
                                   vertical: 16),
                               shrinkWrap: true,
                               children: [
                                 'Delete',
                               ]
                                   .map(
                                     (e) => InkWell(
                                     child: Container(
                                       color: Colors.white10,
                                       padding:
                                       const EdgeInsets.symmetric(
                                           vertical: 12,
                                           horizontal: 16),
                                       child: Text(e),
                                     ),
                                     onTap: () {
                                       deletepost(posts.postId);

                                       // remove the dialog box
                                       Navigator.of(context).pop();
                                     }),
                               )
                                   .toList()),
                         );
                       },
                     );
                   },
                   icon: const Icon(Icons.more_vert,color: Colors.white,),
                 )
               ],
             ),
           ),
           SizedBox(
             height: 20,
           ),
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: Container(
               width: double.infinity,
               height: MediaQuery.of(context).size.height*0.8,
               decoration:BoxDecoration(
                 image: DecorationImage(image:NetworkImage(posts.postUrl),fit: BoxFit.cover)

               ) ,
             ),
           ),
           SizedBox(height: 10,),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               children: [
                 Text(posts.username,style: TextStyle(fontSize: 15,color: Colors.white)),
                 SizedBox(width: 10,),
                 Text(posts.description,style: TextStyle(fontSize: 15,color: Colors.white)),
               ],
             ),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               IconButton(
                 onPressed: (){
                   addtofavourite(posts.postId, userProvider.myUser!.uid, posts.likes);
                 },
                 icon: Icon(Icons.favorite,color: Colors.white,),
               ),
               IconButton(
                 onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (c){
                  return CommentScreen(posts);
                }))  ;

                 },
                 icon: Icon(Icons.message,color: Colors.white,),
               ),
               IconButton(
                 onPressed: (){},
                 icon: Icon(Icons.send,color: Colors.white,),
               )
             ],
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
children: [
  Text(' ${posts.likes.length}  likes ',style: TextStyle(fontSize: 15,color: Colors.white),),
  Text(DateFormat.yMMMd().format(posts.datePublished ,),style: TextStyle(fontSize: 15,color: Colors.white)),
]
             ),
           )

         ],
       ),

      );

  }

  deletepost(String postId){
    DatabaseUtils.deletepost(postId);

  }
  addtofavourite(String postId,String uid,List likes)  async {
    await DatabaseUtils.likePost(postId, uid, likes);


  }

}
