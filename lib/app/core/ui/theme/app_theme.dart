import 'package:flutter/material.dart';

sealed class AppTheme {
  
  static final theme = ThemeData(
         textTheme: TextTheme(
          labelMedium: TextStyle(fontSize: 19,fontWeight: FontWeight.w600),
          bodySmall: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
          displayLarge: TextStyle(
            fontSize: 27,fontWeight: FontWeight.bold
          )
         
         ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      );
}