import 'package:flutter/material.dart';
import 'package:flutter_app/shared_ui/navigation_drawer.dart';

import 'hometabs/favorites.dart';
import 'hometabs/popular.dart';


class HeadLineNews extends StatefulWidget {
  @override
  _HeadLineNewsState createState() => _HeadLineNewsState();
}
enum PopMenu { Help, About, Contact, Settings }


class _HeadLineNewsState extends State<HeadLineNews>with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("عناوين الأخبار",style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),),
        centerTitle: false,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {},),
          _popUpMenu(context),
        ],
        bottom: TabBar(
          tabs: [
            Tab(
              text: "ما الجديد",
            ),
            Tab(
              text: "الرائج",
            ),
            Tab(
              text: "المفضلة",
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: Center(
          child: TabBarView(
            children: [
              Favorites(),
              Popular(),
              Favorites(),
            ],
            controller: _tabController,
          )),
      drawer: NavigationDrawer(),
    );
  }

  Widget _popUpMenu(BuildContext context) {
    return PopupMenuButton<PopMenu>(
      itemBuilder: (context) {
        return [
          PopupMenuItem<PopMenu>(
            value: PopMenu.Help,
            child: Text('الدعم الفني'),
          ),
          PopupMenuItem<PopMenu>(
            value: PopMenu.About,
            child: Text('لمحة عن التطبيق'),
          ),
          PopupMenuItem<PopMenu>(
            value: PopMenu.Contact,
            child: Text('التواصل'),
          ),
          PopupMenuItem<PopMenu>(
            value: PopMenu.Settings,
            child: Text('الإعدادت'),
          ),
        ];
      },
      onSelected: (PopMenu menu) {},
      icon: Icon(Icons.more_vert),
    );
  }
}
