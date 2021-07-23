
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:red/api/auth_services.dart';
import 'package:velocity_x/velocity_x.dart';

class Profile extends StatefulWidget {
  dynamic data;
  Profile(this.data);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthService authService=new AuthService();
  dynamic data;
  var _form_key=GlobalKey<FormState>();
  List dropdown=[
    "A+", "B+", "O+","AB+","A-","B-","AB-","O-"];
  String name,email,password,city,bg,number;
  final cname=new TextEditingController();
  final cemail=new TextEditingController();
  final cpass=new TextEditingController();
  final ccity=new TextEditingController();
  final cnum=new TextEditingController();
  var isloading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data=widget.data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          upperdes(),
          login_form(),
        ],
      ),
    );
  }

  Widget upperdes()
  {
    return Stack(
      children: [
        ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.redAccent,Colors.pinkAccent]
                )
            ),
            height: context.percentHeight*30,
            width: context.percentWidth*100,
          ),
        ),
        Container(
          height: context.percentHeight*30,
          padding: EdgeInsets.only(bottom: 20),
          child: Align(
            alignment: Alignment.bottomCenter,
//          top: context.percentHeight*7,
//          left: context.percentHeight*20,
            child: CircleAvatar(
              backgroundImage: (data['image'] != null)
                  ? NetworkImage(data['image']):AssetImage('assets/avimg.png'),
                 radius: context.percentHeight*10,
              backgroundColor: Colors.white,
                ),
              ),
            ),
          Container(
          height: context.percentHeight*24,
          width: context.percentWidth*75,
          child: Align(
            alignment: Alignment.bottomRight,
//          top: context.percentHeight*19,
//          left: context.percentHeight*35,
            child: Container(
              height: 40,
              child: IconButton(
                onPressed: ()
                async {
                  await uploadPhoto();
                },
                padding: EdgeInsets.all(2),
                icon: Icon(Icons.edit,color: Colors.white,),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white,width: 3),
                  color: Colors.red
              ),
            ),
          ),
        ),
        isloading?Container(
          height: context.percentHeight*35,
          child: CircularProgressIndicator().opacity(value: 1).centered().h2(context),
        ):
        CircularProgressIndicator().centered().opacity(value: 0)
      ],
    );
  }

  Widget login_form()
  {
    return SingleChildScrollView(
      child: Container(
        height: context.percentHeight*60,
        child: Padding(
          padding: const EdgeInsets.only(right: 30,left:30,top: 40,bottom: 20),
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
                        padding: const EdgeInsets.only(top:0,bottom: 20),
                        child: TextFormField(
                          controller: cname,
                          validator: (String val){
                            if(val.isEmpty)
                              return "Field cannot be empty";
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: data['name'],
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                              ),
                              enabled: false,
                              labelText: "Name",
//                              prefixIcon: Icon(Icons.person)
                          ),
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: data['city'],
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                            labelText: "City",
//                              prefixIcon: Icon(Icons.person)
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          enabled: false,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: cnum,
                          validator: (String val){
                            if(val.isEmpty)
                              return "Field cannot be empty";
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: data['number'],
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                            labelText: "Phone number",
                            enabled: false,
//                              prefixIcon: Icon(Icons.person)
                          ),
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: data['bloodgp'],
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                            labelText: "Blood Group",
                            enabled: false,
                          ),
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

  Future<void> uploadPhoto()
  async {
    isloading=true;
    setState(() {
    });
    File _image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
//        VxToast.showLoading(context);
        _image = File(pickedFile.path);
        String result=await authService.uploadPhotoFirebase(_image);
        if(result=="Success")
          {
            isloading=false;
            data=await authService.getData();
            setState(() {
            });
          }
//        else
//          Fluttertoast.showToast(msg:result);

      } else {
        isloading=false;
        setState(() {
        });
        Fluttertoast.showToast(msg:'No image selected.');
      }

  }
}
