import 'package:flutter/material.dart';

class User {
  int userid;
  String username;
  String userpass;
  String userdealer;
  int userstatu;

  User({
    required this.userid,
    required this.username,
    required this.userpass,
    required this.userdealer,
    required this.userstatu,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'],
      username: json['username'],
      userpass: json['userpass'],
      userdealer: json['userdealer'],
      userstatu: json['userstatu'],
    );
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['username'] = this.username;
    data['userpass'] = this.userpass;
    data['userdealer'] = this.userdealer;
    data['userstatu'] = this.userstatu;
    return data;
  }
}
