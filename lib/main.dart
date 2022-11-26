import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_insta/layout/profile/myuser.dart';
import 'package:new_insta/layout/search/search_screen.dart';

import 'package:new_insta/provider/user-provider.dart';
import 'package:new_insta/utils/my_theme.dart';
import 'package:provider/provider.dart';

import 'layout/profile/profilescreen.dart';
import 'login/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (BuildContext context) {
        return UserProvider();
      },
      child: MaterialApp(

        home:LoginScreen(),
        theme: MyThemeData.darkTheme,

      ),
    );
  }
}

