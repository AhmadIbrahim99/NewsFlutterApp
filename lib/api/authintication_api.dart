import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:flutter_app/utilities/apiutilitie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationApi{
  Future<bool> login(String email,String password) async{
    var authapi=Uri.parse("");
    Map<String,String>headers={
      "Accept" : "application.json",
      "content-type" : "application/x-ww-urlencoded"
    };
    Map<String,String>body={
      "email" : email ,
      "password" : password
    };
    var response=await http.post(authapi,headers: headers, body: body);

    if(response.statusCode==200){
      try{
        var jsonData=jsonDecode(response.body);
        var data=jsonData('data');
        var token=data('token');
        SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
        sharedPreferences.setString("token", token);
        return true;
      }catch(Exception){
        return false;
      }

    }
  }
}