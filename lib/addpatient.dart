import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';


class AddPatient extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {

  int selectedRadio;
  int selectedRadio2;
  var _form_key=GlobalKey<FormState>();
  var name;
  var address;
  var num;
  var units;
  // final cname=new TextEditingController();
  // final caddress=new TextEditingController();
  // final cnum=new TextEditingController();
  // final cunits=new TextEditingController();
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
      body:
      // Container(
      //   height: context.percentHeight*100,
      //   width: context.percentWidth*100,
      //   child: Card(
      //     elevation: 3,
      //     margin: EdgeInsets.symmetric(
      //       vertical: 20,
      //       horizontal: 10
      //     ),
           SingleChildScrollView(
            child: Column(
              children: [
                "Paitent Details".text.xl.bold.make(),
                div(),
                formdata(),
                "Required Type".text.xl.bold.make(),
                div(),
                Row(
                  children: [
                    radioGroup(1,"Blood"),
                    radioGroup(2,"Platlets"),
                  ],
                ),
              ]
            ),
          ),
        // ),
      // ),
    );
  }
  List<Widget> childr()
  {
    return [
      "Paitent Details".text.xl.bold.make(),
      div(),
      // formdata(),
      "Required Type".text.xl.bold.make(),
      div(),
      Row(
        children: [
          radioGroup(1,"Blood"),
          radioGroup(2,"Platlets"),
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
      // SizedBox(
      //   height: context.percentHeight*23,
      //   child: GridView.count(
      //     crossAxisCount: 4,
      //     children: bloodGroup(),
      //   ),
      // ),
      "Tell us about your condition".text.xl.bold.make(),
      div(),
      radioGroup(1, "Is Critical?")
    ];
  }
  Widget formdata()
  {
    return Form(
      key: _form_key,
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
            changeValue(val);
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
    return List<Widget>.generate(8, (index) => Flexible(
        child: Container(
          child: Card(
            elevation: 2,
            child: TextButton(
              child: dropdown[index].text.make(),
              onPressed: (){
                setState(() {
                  checkedindex=index;
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
        )
    ));
  }
  void changeValue(val)
  {
    selectedRadio=val;
    setState(() {});
  }
}
