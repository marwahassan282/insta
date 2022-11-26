import 'package:flutter/material.dart';

class MyThemeData {

  static const mobileBackgroundColor = Color.fromRGBO(0, 0, 0, 1);
  static Color BlackColor = Color(0xFF242424);

  static Color WhiteColor = Color(0xFFFFFFFF);




  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: mobileBackgroundColor,
      primaryColor: mobileBackgroundColor,
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: WhiteColor)),
      textTheme: TextTheme(
        headline3: TextStyle(
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.w400,),
        headline1: TextStyle(
          fontSize: 30,
          color: WhiteColor,
          fontWeight: FontWeight.w700,
        ),
        headline2: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        subtitle1: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.white, unselectedItemColor: Colors.grey));
}
