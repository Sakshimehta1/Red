import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red/addpatient.dart';
import 'package:red/api/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:red/homepage.dart';
import 'package:red/login.dart';
import 'register.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().UserStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return login();
          }
          return homepageLoadData();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
