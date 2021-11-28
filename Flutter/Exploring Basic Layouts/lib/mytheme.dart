import 'package:flutter/material.dart';


class MyTheme {
  static ThemeData get lightTheme => ThemeData(
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: 'Roboto',

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>( Colors.green[500]! ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))
        )
      )
    ),

    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(),
      labelColor: Colors.white,
      labelPadding: EdgeInsets.symmetric( horizontal: 40),
    ),
  );
}