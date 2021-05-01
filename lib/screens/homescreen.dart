import 'package:flutter/material.dart';
import 'package:flutter_app/models/news.dart';
import 'package:flutter_app/screens/pages/about.dart';
import 'package:flutter_app/screens/pages/contact.dart';
import 'package:flutter_app/screens/pages/settings.dart';
import 'package:flutter_app/shared_ui/navigation_drawer.dart';
import 'hometabs/popular.dart';
import 'hometabs/whatsnew.dart';
import 'hometabs/favorites.dart';
import 'package:flutter_app/api/authors_api.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum PopMenu { Help, About, Contact, Settings }

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Future<NewsModel> _newsmodel;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    _newsmodel = AuthorsAPI().fetchAllAuthors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "استكشف",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
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
          WhatsNew(),
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
              value: PopMenu.Help, child: Text('الدعم الفني')),
          PopupMenuItem<PopMenu>(
              value: PopMenu.About, child: Text('لمحة عن التطبيق')),
          PopupMenuItem<PopMenu>(
              value: PopMenu.Contact, child: Text('التواصل')),
          PopupMenuItem<PopMenu>(
              value: PopMenu.Settings, child: Text('الإعدادت')),
        ];
      },
      onSelected: (PopMenu menu) {
        switch (menu) {
          case PopMenu.Help:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Contact();
            }));
            break;

          case PopMenu.About:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return About();
            }));
            break;

          case PopMenu.Contact:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Contact();
            }));
            break;

          case PopMenu.Settings:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Settings();
            }));
            break;
        }
      },
      icon: Icon(Icons.more_vert),
    );
  }
}
