import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red/api/auth_services.dart';
import 'package:red/register.dart';
import 'package:velocity_x/velocity_x.dart';
class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  var _form_key=GlobalKey<FormState>();
  final cemail=new TextEditingController();
  final cpass=new TextEditingController();
  var obscurePass=true;
  IconData icon_passwdeye=Icons.remove_red_eye;
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
            top: context.percentHeight*10,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Welcome Back !").text.white.extraBold.xl4.make(),
              )),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                  child: login_form(),
                ),
              ),
            ],
          ),
          BloodDrop(),
          Positioned(
              top: context.percentHeight*63.5,
              left: context.percentWidth*27,
              child: Button()),
          Positioned(
            top: context.percentHeight*75,
            left: context.percentWidth*37,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text:" Register",
                      style: GoogleFonts.varelaRound(
                        fontSize: 17,
                        color: Colors.red
                      ),
                      recognizer: TapGestureRecognizer()..onTap=(){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context)=>register()));
                      }
                  )
                ],
                text: "New ?",
                style: GoogleFonts.varelaRound(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),
          )
        ],
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

  Widget BloodDrop()
  {
    return Positioned(
        top: context.percentHeight*29,
        left: context.percentWidth*40,
        child: Container(
            height: context.percentWidth*20,
            width: context.percentWidth*20,
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


  Widget login_form()
  {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      elevation: 10,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 60),
        child: Form(
          key: _form_key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                  padding: const EdgeInsets.only(bottom: 0),
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

            ],
          ),
        )
      ),
    );
  }
  var isloading=false;
  Widget Button()
  {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 50),
        child: isloading?SpinKitWave(color: Colors.white,size: 20,):Text("Login",
          style: GoogleFonts.varelaRound(),
        ).text.center.extraBold.white.xl.uppercase.make(),
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80)
        )
      ),
      onPressed: () async {
        if(_form_key.currentState.validate())
          {
            isloading =true;
            setState(() {
            });
            AuthService authService=new AuthService();
            await authService.login(cemail.text, cpass.text);
            isloading =false;
            setState(() {
            });
          }
      },
    );
  }
}
