import 'package:flutter/material.dart';
import 'package:flutter_app/shared_ui/navigation_drawer.dart';

class TwitterFeed extends StatefulWidget {
  @override
  _TwitterFeedState createState() => _TwitterFeedState();
}

class _TwitterFeedState extends State<TwitterFeed> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تويتر",
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        itemBuilder: (context, position) {
          return Card(
            child: Column(
              children: [
                _cardHeader(),
                _cardBody(),
                _drawDivider(),
                _cardFooter(),
              ],
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _cardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text("أحمد إبراهيم",style: TextStyle(fontSize: 16),),
                SizedBox(width: 3,),
                Text("@غزة",style: TextStyle(color: Colors.grey.shade500),),
              ],
            ),
            SizedBox(height: 8,),
            Text("Fri, 12 May 2017 * 14.30",style: TextStyle(color: Colors.grey.shade500),),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircleAvatar(
            backgroundImage: ExactAssetImage('assets/images/shop.jpg'),
            radius: 24,
          ),
        ),
      ],
    );
  }

  Widget _cardBody() {
    return Padding(padding: EdgeInsets.only(left: 16,right: 16,bottom: 8),
      child: Text("مرحباً في هذا التطبيق من خلال تويترمرحباً في هذا التطبيق من خلال تويترمرحباً في هذا التطبيق من خلال تويتر ",
      style: TextStyle(
        fontSize: 16,
        height: 1.2,
        color: Colors.grey.shade900,
      ),textAlign: TextAlign.end,),

    );
  }

  Widget _cardFooter() {
    return Row(
      children: <Widget>[
        const SizedBox(width: 8),
        IconButton(icon : Icon(Icons.repeat),onPressed: (){},color: Colors.orange,),
        Text("25",style: TextStyle(color: Colors.grey.shade500),),
        SizedBox(width: MediaQuery.of(context).size.width *0.39,),
        TextButton(
          child: const Text('مشاركة',style: TextStyle(color: Colors.orange)),
          onPressed: () {
            /* ... */
          },
        ),
        const SizedBox(width: 8),
        TextButton(
          child: const Text('فتح',style: TextStyle(color: Colors.orange),),
          onPressed: () {
            /* ... */
          },
        ),
      ],
    );
  }

  Widget _drawDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey.shade200,
      margin: EdgeInsets.only(top: 8),
    );
  }
}
