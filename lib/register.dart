import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red/api/auth_services.dart';
import 'package:red/api/endpoints.dart';
import 'package:red/homepage.dart';
import 'package:red/login.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {

  var _form_key=GlobalKey<FormState>();
  List dropdown=[
    "A+", "B+", "O+","AB+","A-","B-","AB-","O-"];
  String _selectedbg;
  String name,email,password,city,bg,number;
  final cname=new TextEditingController();
  final cemail=new TextEditingController();
  final cpass=new TextEditingController();
  final ccity=new TextEditingController();
  final cnum=new TextEditingController();
  var obscurePass=true;
  var showbgError=false;
  IconData icon_passwdeye=Icons.remove_red_eye;
  AuthService authService=new AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ClipPath(
              clipper: DiagonalPathClipperOne(),
              child: VxBox().red600.height(context.percentHeight*50).make()
          ),
          Positioned(
              top: context.percentHeight*5,
              left: context.percentHeight*7,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Welcome to RED !").text.white.extraBold.xl3.make(),
              )),

          Positioned(
//            top: context.percentHeight*40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                    height: context.percentHeight*65,
                    child: login_form(),
                  ),
                ),
              ],
            ),
          ),
          Blooddrop(),
          Positioned(
              top: context.percentHeight*85,
              left: context.percentWidth*20,
              child: Button()),
          Positioned(
            top: context.percentHeight*95,
            left: context.percentWidth*15,
            child: RichText(
              text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text:" Login",
                        style: GoogleFonts.varelaRound(
                            fontSize: 17,
                            color: Colors.red
                        ),
                        recognizer: TapGestureRecognizer()..onTap=(){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context)=>login()));
                        }
                    )
                  ],
                  text: "Already have an Account ?",
                  style: GoogleFonts.varelaRound(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget login_form()
  {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        elevation: 10,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(right: 30,left:30,top: 20,bottom: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _form_key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top:20,bottom: 20),
                      child: TextFormField(
                        controller: cname,
                        validator: (String val){
                          if(val.isEmpty)
                            return "Field cannot be empty";
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(40)
                            ),
                            hintText: "Name",
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person)
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: cemail,
                        validator: (String val){
                          if(val.isEmpty)
                            return "Field cannot be empty";
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(40)
                            ),
                            hintText: "Email",
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email)
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: cpass,
                        validator: (String val){
                          if(val.isEmpty)
                            return "Field cannot be empty";
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(40)
                            ),
                            hintText: "Password",
                            labelText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(icon_passwdeye),
                              onPressed: (){
                                toggle_pass();
                              },
                            ),
                            prefixIcon: Icon(Icons.lock)
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscurePass,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: ccity,
                        validator: (String val){
                          if(val.isEmpty)
                            return "Field cannot be empty";
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(40)
                            ),
                            hintText: "City",
                            labelText: "City",
                            prefixIcon: Icon(Icons.location_on)
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey
                                  ),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  FaIcon(FontAwesomeIcons.tint,color: Colors.grey[500],),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: DropdownButton(
                                          underline: SizedBox(),
                                          value: bg,
                                          isExpanded: true,
                                          hint: "Blood Group".text.make(),
                                          onChanged: (new_val){
                                            bg=new_val;
                                            setState(() {
                                            });
                                          },
                                          items: dropdown.map((item){
                                            return DropdownMenuItem(
                                                value: item,
                                                child: "$item".text.make());
                                          }).toList()
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            showbgError?"Field cannot be empty".text.red600.make():SizedBox(),
                          ],
                        )
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: TextFormField(
                        controller: cnum,
                        validator: (String val){
                          if(val.isEmpty)
                            return "Field cannot be empty";
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(40)
                            ),
                            hintText: "Phone Number",
                            labelText: "Phone Number",
                            prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
  void toggle_pass()
  {
    obscurePass=!obscurePass;
    icon_passwdeye=obscurePass?Icons.visibility:Icons.visibility_off;
    setState(() {
    });
  }
  var isloading=false;
  Widget Button()
  {
    return Container(
      width: context.percentWidth*63,
      child: TextButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
          child: isloading?SpinKitWave(color: Colors.white,size: 20,):Text("Become a Donor",
            style: GoogleFonts.varelaRound(
              fontWeight: FontWeight.bold
            ),
          ).text.center.extraBold.white.xl.uppercase.make(),
        ),
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80)
            )
        ),
        onPressed: ()async{
          bg.isEmptyOrNull?showbgError=true:showbgError=false;
              setState(() {
              });
          if(_form_key.currentState.validate()&&!bg.isEmptyOrNull)
            {
              isloading=true;
              setState(() {
              });
               await registertoFirebase();
            }
          },
      ),
    );
  }

   void registertoFirebase()
  async {

    name=cname.text;
    email=cemail.text;
    password=cpass.text;
    city=ccity.text;
    number=cnum.text;
    var data={
      "name":name,
      "email":email,
      "city":city,
      "bloodgp":bg,
      "number":number,
    };
    var result=await authService.registerUser(email, password,context);
    if(result!=null)
      {
        await authService.saveDatatoFirebase(data);
        VxToast.show(context, msg: "Saved data");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>homepageLoadData()));
      }
      isloading=false;
      setState(() {
      });
  }
  Widget Blooddrop()
  {
    return Positioned(
        top: context.percentHeight*13,
        left: context.percentWidth*42,
        child: Container(
            height: context.percentWidth*17,
            width: context.percentWidth*17,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
//                        spreadRadius: 0.1,
                      blurRadius: 5
                  )
                ]
            ),
            child: Center(child: FaIcon(FontAwesomeIcons.tint,color: Colors.red,size: 37,))
        ));
  }
}
