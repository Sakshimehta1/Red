
import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:red/api/auth_services.dart';
import 'package:red/login.dart';
import 'package:red/register.dart';
import 'package:red/wrapper.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:velocity_x/velocity_x.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  void initState()
  {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
//    StreamProvider<FirebaseUser>.value(
//      value: AuthService().UserStream,
//      initialData: null,
//      child: Wrapper(),
//    );


    return FutureBuilder(
      future: _initialization,
      builder: (context,snapshot){
          if(snapshot.hasError)
            {
              return Text("Error");
            }
          else if(snapshot.connectionState==ConnectionState.done)
            {
              Timer(Duration(milliseconds: 400),(){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context)=>Wrapper()));
              });
              return splashui();
            }
          else
            return splashui();
      },
    );
  }
  Widget splashui()
  {
    var h=context.percentWidth*50;
    var w=context.percentWidth*50;
    return Container(
      color: Colors.white,
      height: context.percentHeight*100,
      child: Stack(
        children: [
          ClipPath(
              clipper: WaveClipperOne(),
              child: VxBox().red600.height(context.percentHeight*20).make()
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: w,
                  height: h,
                  child: Image.asset("assets/newbl.png"),
                  margin: EdgeInsets.all(30),
//                  child: FaIcon(FontAwesomeIcons.tint,color: Colors.red,size: 97,),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: "RED",
                    style: GoogleFonts.varelaRound(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(text: " - Find Blood Donor",
                          style: GoogleFonts.varelaRound(color: Colors.black))
                    ]
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
