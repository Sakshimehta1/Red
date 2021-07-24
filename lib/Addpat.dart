import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'api/auth_services.dart';

class Addnew extends StatefulWidget {
  // const Addnew({Key? key}) : super(key: key);

  @override
  _AddnewState createState() => _AddnewState();
}

class _AddnewState extends State<Addnew> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var name;
  var address;
  var num;
  var units;
  int selectedRadio;
  int selectedRadio2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio=0;
    selectedRadio2=0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Request Blood".text.make(),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
        height: context.percentHeight*100,
        //   width: context.percentWidth*100,
        child: SingleChildScrollView(
          child: Column(
            children: [
              "Paitent Details".text.xl.bold.make(),
              div(),
              form(),
              "Required Type".text.xl.bold.make(),
              div(),
              Row(
                children: [
                  radioGroup(1,"Blood"),
                  radioGroup(2,"Platlets")
                ],
              ),
              Row(
                children: [
                  radioGroup(3,"Plasma"),
                  radioGroup(4,"Plasma\n(Covid-19)"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              "Required Blood Group".text.xl.bold.make(),
              div(),
              SizedBox(
                height: context.percentHeight*23,
                child: GridView.count(
                  crossAxisCount: 4,
                  children: bloodGroup(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // TextButton(
              //   child: ,
              // )
              "Tell us about your condition".text.xl.bold.make(),
              div(),
              Row(
                children: [
                  radioGroup2(1, "Is Critical?"),
                ],
              ),
              Button()
            ],
          ),
        ),
      ),
    );
  }

  Widget form()
  {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        // key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:10,bottom: 0),
                child: TextFormField(
                  // controller: cname,
                  initialValue: "",
                  onSaved: (String value)
                  {
                    name=value;
                  },
                  validator: (String val){
                    if(val.isEmpty)
                      return "Field cannot be empty";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
//                  hintText: "Name",
                    labelText: "Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:7,bottom: 0),
                child: TextFormField(
                  initialValue: "",
                  // controller: cnum,
                  onSaved: (String value)
                  {
                    num=value;
                  },
                  keyboardType: TextInputType.number,
                  validator: (String val){
                    if(val.isEmpty)
                      return "Field cannot be empty";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:7,bottom: 0),
                child: TextFormField(
                  // controller: caddress,
                  initialValue: "",
                  onSaved: (String value)
                  {
                    address=value;
                  },
                  validator: (String val){
                    if(val.isEmpty)
                      return "Field cannot be empty";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Address",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      prefixIcon: Icon(Icons.add_location)
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:7,bottom: 14),
                child: TextFormField(
                  // controller: cunits,
                  initialValue: "",
                  onSaved: (String value)
                  {
                    units=value;
                  },
                  keyboardType: TextInputType.number,
                  validator: (String val){
                    if(val.isEmpty)
                      return "Field cannot be empty";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Required Blood Units",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      prefixIcon: Icon(FontAwesomeIcons.tint)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  var type="";
  var isloading=false;
  var bg="";
  var condition="No";
  Widget Button()
  {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 30),
        child: isloading?SpinKitWave(color: Colors.white,size: 20,):Text("Request Blood",
          style: GoogleFonts.varelaRound(),
        ).text.center.extraBold.white.xl.uppercase.make(),
      ),
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80)
          )
      ),
      onPressed: () async {

        if(_formkey.currentState.validate())
        {
          _formkey.currentState.save();
          dynamic data={
            "name": name,
            "number":num,
            "address":address,
            "units":units,
            "type":type,
            "bg":bg,
            "condition":condition,
            // DateTime.now().microsecondsSinceEpoch
          };
          print(data);
          isloading =true;
          setState(() {
          });

          AuthService authService=new AuthService();
          await authService.addPatient(data);
          // data.putIfAbsent("created", () => FieldValue.serverTimestamp());
          // await authService.addPatient(data);
          isloading =false;
          setState(() {
          });
          VxToast.show(context, msg: "Blood Request made Successfully",bgColor: Colors.green);
          Navigator.pop(context);
        }
      },
    );
  }
  Widget radioGroup(val,String text)
  {
    return Flexible(
      child: RadioListTile(
          value: val, groupValue: selectedRadio, activeColor: Colors.red,
          contentPadding: EdgeInsets.zero,
          title: text.text.make(),
          onChanged: (val){
            changeValue(val,text);
          }),
    );
  }
  Widget radioGroup2(val,String text)
  {
    return Flexible(
      child: RadioListTile(
          value: val, groupValue: selectedRadio2, activeColor: Colors.red,
          contentPadding: EdgeInsets.zero,
          title: text.text.make(),
          onChanged: (val){
            selectedRadio2=val;
            condition=condition=="Yes"?"No":"Yes";
            setState(() {});
          }),
    );
  }
  Widget div()
  {
    return Divider(
      thickness: 2,
      color: Colors.red[200],
    );
  }
  int checkedindex=-1;
  List<Widget> bloodGroup()
  {
    List<Widget> widgets=[];
    List<String> dropdown=[
      "A+", "B+", "O+","AB+","A-","B-","AB-","O-"];
    return List<Widget>.generate(8, (index) => Container(
      width: 30,
      child: Card(
        elevation: 2,
        child: TextButton(
          child: dropdown[index].text.make(),
          onPressed: (){
            setState(() {
              checkedindex=index;
              bg=dropdown[index];
            });
          },
          style: TextButton.styleFrom(
            primary: Colors.red,
            textStyle: TextStyle(
                fontSize: 15,
                color: Colors.red,
                fontWeight: FontWeight.bold
            ),
            backgroundColor: checkedindex==index?Colors.red[200]:Colors.white,
          ),
        ),
      ),
    ));
  }
  void changeValue(val,bloodtype)
  {
    selectedRadio=val;
    type=bloodtype;
    setState(() {});
  }
}
