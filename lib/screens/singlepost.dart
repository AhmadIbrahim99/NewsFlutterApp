import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/models/news.dart';

class SinglePost extends StatefulWidget {
  final Article article;

  SinglePost(this.article);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {

   static int p = 30;
  int countComments=p-3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.article.title,
                maxLines: 2,
              ),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.article.urlToImage),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, position) {
              if (position == 0) {
                return _TheFirstCard();
              } else if (position == 1) {
                return _headerOfComents();
              } else if (position >= 2 && position < (p - 1)) {
                return _allComments();
              } else {
                return _drawComent();
              }
            }, childCount: p),
          ),
        ],
      ),
    );
  }

  Widget _drawSingleCard(Article article) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    article.title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    article.content,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    article.description,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    article.source.name
                        .toString()
                        .substring(5, article.source.name.toString().length),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    article.urlToImage.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      article.author,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer,
                    ),
                    Text(
                      article.publishedAt.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _allComments() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("أحمد إبراهيم أبو نجا"),
                    Text("ساعة"),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundImage: ExactAssetImage("assets/images/shop.jpg"),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Text(
            "تعليق تعليق تعليق تعليق تعليق تعليق تعليق تعليق تعليق تعليق تعليق تعليق",
            maxLines: 2,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _drawComent() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Card(
        child: TextField(
          textAlign: TextAlign.end,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'هل لديك تعليق؟',
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {},
              )),
        ),
      ),
    );
  }

  Widget _headerOfComents() {
    return Container(
        padding: EdgeInsets.only(top: 16, right: 8, left: 8, bottom: 8),
        color: Colors.white,
        child: Card(
          child: Text(
            "Comments$countComments",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ));
  }

  Widget _TheFirstCard() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _drawSingleCard(widget.article),
        ],
      ),
    );
  }
}
