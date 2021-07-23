import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red/homepage.dart';
import 'package:red/register.dart';
import 'package:red/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: splash(),
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.red[600],
        fontFamily: 'Georgia',
        textTheme: GoogleFonts.varelaRoundTextTheme(
          Theme.of(context).textTheme,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.red,
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
            backgroundColor: Colors.red,
          )
        ),
    ),
    debugShowCheckedModeBanner: false,
    );
  }
}
