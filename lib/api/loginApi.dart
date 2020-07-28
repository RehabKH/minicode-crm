import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class LoginApi{
  String token;


  login(String userName, String pass) async {
    // print("phone: " + phone);
    await getAccessToken();
    print(token);
    var response = await http
        .get("http://104.196.134.107/AfitAPI/api/user?UserName=$userName&PSWRD=$pass"
        ,
        headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var result = json.decode(response.body);
    await saveUserData(result);
    print(result[0]["EmpID"]);
    //result["user"]
    //result["token"]
    print("login result: " + result.toString());
 

  }
 confirmCode(String code) async {
    // print("phone: " + phone);
    var response = await http
        .post("http://104.196.134.107/AfitAPI/token",
        body: {
          "username":code,
          "password":code,
          "grant_type":"password"
        });
    var result = json.decode(response.body);
    
    print("code login result: " + result.toString());
    if(code == "MiniCode"){
saveAccessToken(result["access_token"]);
return "Done";
    }
    else{
return result["error"];
    
    }
  }

   Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
     prefs.setString("accessToken",token );
   }

     Future<void> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    token= prefs.getString("accessToken");
   }

    Future<void> saveUserData(userData) async {
    final prefs = await SharedPreferences.getInstance();
     prefs.setInt("UserId",userData[0]["UserId"] );
     prefs.setString("UserName",userData[0]["UserName"] );
     prefs.setString("PSWRD",userData[0]["PSWRD"] );
     prefs.setInt("EmpID",userData[0]["EmpID"] );

   }
}