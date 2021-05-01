import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app/api/authintication_api.dart';
import 'package:flutter_app/screens/homescreen.dart';


class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final _formKey = GlobalKey<FormState>();

  AuthenticationApi authenticationApi=AuthenticationApi();

  bool isLoggin=false;
  bool loginerror=false;

  TextEditingController _name;
  TextEditingController _password;

  String username;
  String passwordUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name=TextEditingController();
    _password=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("تسجيل الدخول"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: (isLoggin)?_isLoading():_loggIn(),
      ),
    );
  }

  Widget _loggIn(){
    return Form(
      key: _formKey ,
      child: Column(
        textDirection: TextDirection.rtl,
        children: [
          TextFormField(
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: "ادخل الاسم هنا",
              labelText: "ادخل الاسم",
            ),
            validator: (value){
              if(value == null || value.isEmpty){
                return "أرجو إدخال الاسم";
              }
              return null;
            },
          ),
          SizedBox(height: 48,),
          TextFormField(
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: "ادخل كلمة السر هنا",
              labelText:  "ادخل كلمة السر",
            ),
            validator: (value){
              if(value == null ||value.isEmpty){
                return "أرجو إدخال كلمة السر";
              }
              return null;
            },
          ),
          SizedBox(height: 48,),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () async {
                if(_formKey.currentState.validate()){
                  setState(() {
                    isLoggin=true;
                  });
                  username=_name.text;
                  passwordUser=_password.text;
                  var response=await authenticationApi.login(username, passwordUser);
                  if(response){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return HomeScreen();
                    }));
                  }else{
                    //To Do error login
                    loginerror=true;
                  }

                }else{
                  setState(() {
                    isLoggin=false;
                  });
                }
              }, child: Text("تسجيل الدخول"))),
        ],
      ),
    );
  }

  Widget _isLoading(){
    if(loginerror){
      return Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login Error"),
              RaisedButton(onPressed: (){
                setState(() {
                  loginerror=false;
                });
              },child: Text("Try Again",style: TextStyle(color: Colors.white),),),
            ],
          ),
        ),
      );
    }
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
