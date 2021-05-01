import 'package:flutter/material.dart';
import 'package:flutter_app/models/nav_menu.dart';
import 'package:flutter_app/screens/facebookfeed.dart';
import 'package:flutter_app/screens/headline_news.dart';
import 'package:flutter_app/screens/homescreen.dart';
import 'package:flutter_app/screens/instagramfeed.dart';
import 'file:///D:/lab/Documents/flutter_app/lib/screens/logInAndRegestere/loggin.dart';
import 'package:flutter_app/screens/twitterfeed.dart';
class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  static bool isLoggedIn=false;

  List<NavMenuItem> navigationMenu=[
    NavMenuItem("استكشف", ()=> HomeScreen()),
    NavMenuItem("عناوين الأخبار",()=> HeadLineNews()),
    NavMenuItem("تويتر",()=> TwitterFeed()),
    NavMenuItem("إنستقرام",()=> InstagramFeed()),
    NavMenuItem("فيسبوك",()=> FaceBookFeed()),
    (isLoggedIn==true)? NavMenuItem("تسجيل الخروج",()=> FaceBookFeed()):NavMenuItem("تسجيل الدخول",()=> LogIn()),
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*Timer(Duration(seconds:5),(){
      isLoggedIn=false;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 70,left: 24),
        child: ListView.builder(itemBuilder: (context,position){
          return Padding(
            padding: const EdgeInsets.all(8.0),

            child: ListTile(

              title: Text(navigationMenu[position].title,textAlign: TextAlign.center,style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 22
              ),),
              trailing: Icon(Icons.chevron_right,color: Colors.grey.shade400,),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return navigationMenu[position].destination();
                }));
              },

            ),
          );
        },
          itemCount: navigationMenu.length,

        ),
      ),

    );
  }
}
