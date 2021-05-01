import 'package:flutter/material.dart';
import 'screens/onboarding.dart';
import 'utilities/app_theme.dart';
main()  async {
 /*SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
  bool seen=sharedPreferences.getBool('seen');
  Widget _screen;
  if(seen==null || seen==false){
_screen=OnBoarding();
  }else{
    _screen=HomeScreen();
  }*/
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  /*final Widget _screen;
  NewsApp(this._screen);*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: AppTheme.data
    ,
      home: OnBoarding(),
      debugShowCheckedModeBanner: false,
      title: "أخباري",
    );
  }
}
