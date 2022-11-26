import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_insta/addtodatabase/addpost.dart';
import 'package:new_insta/layout/post/getpost.dart';
import 'package:new_insta/layout/profile/myuser.dart';
import 'package:new_insta/layout/profile/profilescreen.dart';
import 'package:new_insta/layout/search/search_screen.dart';

class Homelayout extends StatefulWidget {
  @override
  State<Homelayout> createState() => _HomelayoutState();
}

class _HomelayoutState extends State<Homelayout> {
  int currentindex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: widgets[currentindex],

  bottomNavigationBar: Theme(
    data: Theme.of(context).copyWith(

      canvasColor: Theme.of(context).primaryColor
    ),
    child: BottomNavigationBar(

        onTap: (index){
          currentindex=index;
          setState(() {

          });
        },
        currentIndex: currentindex,
        items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home),
      label: 'home'),
      BottomNavigationBarItem(icon: Icon(Icons.search),
          label: 'search'),
      BottomNavigationBarItem(icon: Icon(Icons.add),
          label: 'addPost'),
      BottomNavigationBarItem(icon: Icon(Icons.person),
          label: 'profile'),



    ]),
  )


    );



  }

  List<Widget>widgets=[
    getPost(),
    SearchScreen(),
    addPost(),
   myuserScreen()


  ];
}
