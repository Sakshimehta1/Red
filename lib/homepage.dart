
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:red/Addpat.dart';
import 'package:red/NavDrawer.dart';
import 'package:red/addpatient.dart';
import 'package:red/api/auth_services.dart';
import 'package:red/model/user.dart';
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
        Timestamp timestamp=document["created"];
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
                      backgroundImage: (data['image'] != null)
                          ? NetworkImage(data['image']):AssetImage('assets/avimg.png'),
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
                        "helloo".textSpan.make()
                      ]).gray500.make(),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
