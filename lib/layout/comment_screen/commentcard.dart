import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_insta/provider/user-provider.dart';
import 'package:provider/provider.dart';

import '../../models/my_comment.dart';




class CommentCard extends StatelessWidget {
  comment comments;
  CommentCard(this.comments);


  @override
  Widget build(BuildContext context) {
    UserProvider userProvider=Provider.of<UserProvider>(context);
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(

                   radius: 24,
                   backgroundImage: NetworkImage('${comments.profilepicture}'),
                 ) ,
                  SizedBox(width: 20,),
                  Row(
                    children:  [
                      Text('${comments.username}',style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(width: 10,),
                      Text(comments.text,style: Theme.of(context).textTheme.subtitle1),


                    ],
                  ),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.favorite))



                ],
              ),
              SizedBox(height: 5,),
              Row(

                children: [
                     Text('number of likes  ')  ,
                   Text('reply  ') ,
                  SizedBox(height: 5,),
                  Text('${DateFormat.yMMMd().format(comments.date )}')

                ],
              )
            ],
          ),


        ),
      );

  }
}
