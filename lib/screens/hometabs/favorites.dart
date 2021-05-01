import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Color> listOfColors = [
    Colors.red,
    Colors.teal,
    Colors.deepOrange,
    Colors.indigo,
    Colors.brown,
    Colors.purple,
  ];
  Random random=Random();
  Color _getRandomColor(){
    return listOfColors[random.nextInt(listOfColors.length)];
  }
  TextStyle _textStyleName =
      TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold);
  TextStyle _textStylemin =
      TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _authorRow(),
                SizedBox(height: 16,),
                _newsItemRow(),
              ],
            ),
          ),
        );
      },
      itemCount: 20,
    );
  }

  Widget _authorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {}),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "اسم الكاتب",
                    style: _textStyleName,
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text(
                        "15 min .",
                        style: _textStylemin,
                      ),
                      Text(
                        "دورة حياة",
                        style: TextStyle(color: _getRandomColor(),),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage('assets/images/shop.jpg'),
                    fit: BoxFit.cover),
                shape: BoxShape.circle,
              ),
              width: 50,
              height: 50,
            //  margin: EdgeInsets.only(left: 4),
            ),
          ],
        ),
      ],
    );
  }

  Widget _newsItemRow() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/images/shop.jpg'),fit: BoxFit.cover
            ),

          ),
          width: 124,
          height: 124,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right : 8.0,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("نص نص نص نص متوى محتوى محتوى",textAlign: TextAlign.end,style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1
                )),
                SizedBox(height: 4,),
                Text("نص نص نص نص متوى محتوى محتوى نص نص نص نص متوى محتوى محتوى نص نص نص نص متوى محتوى محتوى",style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  height: 1.25
                ),textAlign: TextAlign.end,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
