import 'package:flutter/material.dart';
import 'package:flutter_app/api/authors_api.dart';
import 'package:flutter_app/models/news.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../singlepost.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
     future: AuthorsAPI().fetchAllPopular(),
      builder: (context ,AsyncSnapshot snapShot){

        switch(snapShot.connectionState) {
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
            if(snapShot.error !=null){
              //TODO : Handle Error
              _error(snapShot.error);}else{
              if(snapShot.hasData){
                List<Article> news= snapShot.data.articles;
                if(news.length>=3){
                  return ListView.builder(itemBuilder: (context,position){
                    return Card(
                      child: _drawSingleCard(news[position]),
                    );
                  },
                    itemCount:news.length ,
                  );
                }
              }else{
                //TODO : Handle No data
                _noData();
              }
            }
            break;
        }
      return Container(child: Text("No DAta"),);
      },
    );
  }

  Widget _drawSingleCard(Article article) {
    return GestureDetector(
      onLongPress: (){},
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

  String _parsHumanDataTime( String dateTime  ){
    Duration timeAgo = DateTime.now().difference( DateTime.parse(dateTime) );
    DateTime theDifference = DateTime.now().subtract( timeAgo );
    return timeago.format( theDifference );
  }

  String _sympolAuthor(String author){
    bool a=author.contains(',');
    if(a){
      String b=author.substring(0, (author.indexOf(',')));
      int c=b.length;
      if(c>10){
        return b.substring(0,8);
      }else{
        return b;
      }
    }else{
      if(author.length>10){
        return author.substring(0,8);
      }else{
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

  Widget _connectionError(){
    return Container(
      padding: EdgeInsets.all(16),
      child: Text("ConnectionError!!!!"),
    );
  }

  Widget _error(var error){
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
