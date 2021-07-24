import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red/Profile.dart';
import 'package:red/api/auth_services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'myRequest.dart';

class NavDrawer extends StatelessWidget {
  final padding=EdgeInsets.symmetric(horizontal: 20,vertical: 20);
  dynamic data;
  NavDrawer(this.data);
  AuthService _authService= new AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40),
              height: context.percentHeight*37,
              width: context.percentWidth*100,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.redAccent,Colors.pinkAccent]
                  )
              ),
              child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: context.percentHeight*3),
                  CircleAvatar(
                    radius:context.percentHeight*9,
                    backgroundImage: (data['image'] != null)
                        ? NetworkImage(data['image']):AssetImage('assets/avimg.png'),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: context.percentHeight*3),
                  Text(data['name']).text.white.center.fontWeight(FontWeight.bold).xl2.make(),
                  Text(data['email']).text.white.center.xl.make(),

                ],
              ),
            ),
            SizedBox(height: 10),
            Menuitem(text: "Profile",icon: FontAwesomeIcons.solidUserCircle,ontap: (){navigate(context, Profile(data));}),
            Divider(color: Colors.red,height: 1,),
            Menuitem(text: "Active Requests",icon: FontAwesomeIcons.creativeCommonsSampling,ontap: (){}),
            Divider(color: Colors.red,height: 1,),
            Menuitem(text: "My Request",icon: FontAwesomeIcons.handHoldingWater,ontap: (){navigate(context, MyRequest());}),
            Divider(color: Colors.red,height: 1,),
            Menuitem(text: "Logout",icon: Icons.power_settings_new,ontap: (){
              _authService.logout();
            }),
            Divider(color: Colors.red,height: 1,),
//            Menuitem(text: "Profile",icon: Icons.person,ontap: (){}),
//            Menuitem(text: "Profile",icon: Icons.person,ontap: (){}),

          ],
        ),
      ),
    );
  }

  void navigate(BuildContext context,StatefulWidget newpage)
  {
    Navigator.pop(context);
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>newpage));
  }
  Widget Menuitem({
   String text,
    IconData icon,
    Function ontap
})
  {
    return ListTile(
      leading: FaIcon(icon,color: Colors.red,size: 30,),
      title: Text(text,style: GoogleFonts.varelaRound(color: Colors.red,fontSize: 20)),
      onTap: ontap,
    );
  }
}
