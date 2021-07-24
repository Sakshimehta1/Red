
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:red/Addpat.dart';
import 'package:red/NavDrawer.dart';
import 'package:red/addpatient.dart';
import 'package:red/api/auth_services.dart';
import 'package:red/model/user.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timeago/timeago.dart' as timeago;
dynamic data;
class homepageLoadData extends StatelessWidget {
  @override
  AuthService _authService= new AuthService();
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authService.getData(),
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.done)
          {
            if(snapshot.hasData)
              {
                data=snapshot.data;
                return homepage();
              }
          }
        return Container(
          color: Colors.white,
          child: Center(
              child: CircularProgressIndicator())
        );
      },
    );
  }
}

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  final Stream<QuerySnapshot> _patientsStream = FirebaseFirestore.instance.collection('patients').snapshots();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(data),
      appBar: AppBar(
//        title: "hh",
      ),
      floatingActionButton: SpeedDial(
//        animatedIcon: AnimatedIcons.menu_close,
        icon: FontAwesomeIcons.handHoldingWater,
        activeIcon: Icons.close,
        activeLabel: "Request Blood".text.red600.make(),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPress: ()
          {
            reqBlood();
          },
       ),
      body: StreamBuilder(
        stream: _patientsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if(!snapshot.hasData)
            {
              return Center(
                child:Text("No Data to show")
              );
            }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Colors.white,
                child: Center(
                    child: CircularProgressIndicator())
            );
          }

          return list(snapshot);
        },
      )
      );
  }
  void reqBlood()
  {
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>Addnew()));
  }
  Widget list(snapshot)
  {
    return ListView.builder(
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context,index){
        var document=snapshot.data.docs[index];
        String bldgp=document["bg"];
        String hospital=document["address"];
        String type=document["type"];
        String units=document["units"];
        String number=document["number"];
        Timestamp timestamp=document["created"];
        String critical=document["condition"];
        String msg=units+" Units of "+type+" Required";
        return Card(
          margin: EdgeInsets.only(left: 10,right: 10,top: 10),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            // side: BorderSide(color: Colors.red)
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(document["name"]).text.bold.capitalize.xl.make(),
                  contentPadding:EdgeInsets.only(left: 0,right: 0,top: 5),
                  leading: Container(
                    width: context.percentWidth*20,
                    padding: EdgeInsets.only(left: 10,right: 0,bottom: 3),
                    // color: Colors.red,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/avimg.png'),
                      radius: context.percentWidth*10,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  subtitle: "Looking For ".
                  richText.withTextSpanChildren(
                      [bldgp.textSpan.bold.red400.make(),
                        "\nin ".textSpan.gray500.make(),
                        hospital.textSpan.black.make(),
                        "\n".textSpan.make(),
                        timestamp.toDate().timeAgo().textSpan.make(),
                        "\n".textSpan.make(),
                        critical=="Yes"?"Critical".textSpan.bold.green600.make():"".textSpan.make()
                      ]).gray500.make(),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey[200],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          msg,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.phone),
                        color: Colors.green,
                        onPressed: () async {
                          String url='tel:$number';
                          if (await canLaunch(url)) {
                          await launch(url);
                          } else {
                            VxToast.show(context, msg: "Could not contact.");
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                      Builder(
                        builder: (BuildContext context){
                          return IconButton(
                            icon: Icon(Icons.share),
                            color: Colors.green,
                            onPressed: (){
                              share(context,msg, number);
                            },
                          );
                        }
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> share(BuildContext context,text,number)
  async {
    final RenderBox box = context.findRenderObject();
    {
      await Share.share(text+"\n Contact "+number,
          subject: "Donate Blood ",
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }
}
