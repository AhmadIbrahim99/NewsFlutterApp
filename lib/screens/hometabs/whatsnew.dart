import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/api/authors_api.dart';
import 'package:flutter_app/models/news.dart';
import 'package:flutter_app/screens/singlepost.dart';
import 'package:timeago/timeago.dart' as timeago;

class WhatsNew extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _header(),
          _drawStrories(),
          _drawRecentUpdates(),
        ],
      ),
    );
  }

  Widget _header() {
    return FutureBuilder(
      future: AuthorsAPI().fetchAllAuthors(),
      builder: (context, AsyncSnapshot snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.waiting:
            return _loading();
            break;
          case ConnectionState.active:
            return _loading();
            break;
          case ConnectionState.none:
            return _connectionError();
            break;
          case ConnectionState.done:
            if(snapShot.hasData){

              List<Article> art = snapShot.data.articles;
              Random random = new Random();
              int r = random.nextInt(art.length);
              Article articleRandom = art[r];
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return SinglePost(articleRandom);
                  }));
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(articleRandom.urlToImage),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 48, left: 48),
                          child: Text(
                            articleRandom.title,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(right: 34, left: 34, bottom: 2),
                          child: Flexible(
                            child: Text(
                              articleRandom.description,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                            ),

                            /*
                          child: RichText(
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            strutStyle: StrutStyle(fontSize: 12.0),
                            text: TextSpan(
                                style: TextStyle(color: Colors.white,),
                                text: articleRandom.content),
                          ),*/
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            break;
        }
        return Container(
          child: Text("No Data"),
        );
      },
    );
  }

  Widget _drawStrories() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _drawText("أهم القصص"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: FutureBuilder<NewsModel>(
                future:  AuthorsAPI().fetchAllAuthors(),
                builder: (context, AsyncSnapshot snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.waiting:
                      return _loading();
                      break;
                    case ConnectionState.active:
                      return _loading();
                      break;
                    case ConnectionState.done:
                      if (snapShot.error != null) {
                        //TODO : Handle Error
                        _error(snapShot.error);
                      } else {
                        if (snapShot.hasData) {
                          List<Article> news = snapShot.data.articles;

                          if (news.length >= 3) {
                            return Column(
                              children: [
                                _drawSingleCard(
                                    snapShot.data.articles[0]),
                                _drawDivider(),
                                _drawSingleCard(
                                    snapShot.data.articles[1]),
                                _drawDivider(),
                                _drawSingleCard(
                                    snapShot.data.articles[2]),
                              ],
                            );
                          }
                        } else {
                          //TODO : Handle No data
                          _noData();
                        }
                      }
                      break;
                    case ConnectionState.none:
                      //TODO : Handle Problem
                      _connectionError();

                      break;
                  }
//to shut up console
                  return _noData();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawRecentUpdates() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: FutureBuilder<NewsModel>(
        future: AuthorsAPI().recentUpdates(),
        builder: (context, AsyncSnapshot snapShot) {
          switch (snapShot.connectionState) {
            case ConnectionState.waiting:
              return _loading();
              break;
            case ConnectionState.active:
              return _loading();
              break;
            case ConnectionState.none:
              return _connectionError();
              break;
            case ConnectionState.done:
              if (snapShot.error != null) {
                //TODO : Handle Error
                _error(snapShot.error);
              } else {
                if (snapShot.hasData) {
                  List<Article> news = snapShot.data.articles;
                  if (news.length >= 3) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16, bottom: 16),
                          child: _drawText("التحديث الأخير"),
                        ),
                        _drawRecentUpdateCard(
                            Colors.deepOrange, snapShot.data.articles[0]),
                        _drawRecentUpdateCard(
                            Colors.teal, snapShot.data.articles[1]),
                        _drawRecentUpdateCard(
                            Colors.teal, snapShot.data.articles[2]),
                        SizedBox(
                          height: 48,
                        )
                      ],
                    );
                  }
                } else {
                  //TODO : Handle No data
                  _noData();
                }
              }
              break;
          }
          return Container(
            child: _noData(),
          );
        },
      ),
    );
  }

  Widget _drawSingleCard(Article article) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SinglePost(article);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              child: Image(
                image: NetworkImage(article.urlToImage),
                fit: BoxFit.cover,
              ),
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_sympolAuthor(article.author)),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                          ),
                          Text(_parsHumanDataTime(article.publishedAt.toString())),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey,
    );
  }

  Widget _drawText(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.grey.shade800,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  Widget _drawRecentUpdateCard(Color color, Article article) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SinglePost(article);
        }));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(article.urlToImage),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 16, left: 16),
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24, top: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  article.author,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4, bottom: 4, right: 16, left: 16),
              child: Text(
                article.title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.timer,
                    size: 18,
                    color: Colors.grey,
                  ),
                  Text(
                    _parsHumanDataTime(article.publishedAt.toString()),
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _parsHumanDataTime(String dateTime) {
    Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
    DateTime theDifference = DateTime.now().subtract(timeAgo);
    return timeago.format(theDifference);
  }

  String _sympolAuthor(String author) {
    bool a = author.contains(',');
    if (a) {
      String b = author.substring(0, (author.indexOf(',')));
      int c = b.length;
      if (c > 10) {
        return b.substring(0, 8);
      } else {
        return b;
      }
    } else {
      if (author.length > 10) {
        return author.substring(0, 8);
      } else {
        return author;
      }
    }
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _connectionError() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text("ConnectionError!!!!"),
    );
  }

  Widget _error(var error) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(error.toString()),
    );
  }

  Widget _noData() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text("لا يوجد بيانات"),
        ),
      ),
    );
  }
}
