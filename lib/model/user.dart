import 'package:flutter/services.dart';

class UserData
{
  String name;
  String email;
  String address;
  String city;
  String number;
  String bg;

  UserData(this.name,this.email, this.address, this.city, this.number, this.bg);
  UserData.fromSnapshot(Map<String, dynamic> snapshot)
  {
    this.name=snapshot['name'];
    this.email=snapshot['email'];
    this.address=snapshot['address'];
    this.city=snapshot['city'];
    this.number=snapshot['number'];
    this.bg=snapshot['bloodgp'];

  }

}