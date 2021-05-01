import 'package:flutter/material.dart';
import 'package:flutter_app/shared_ui/navigation_drawer.dart';

class FaceBookFeed extends StatefulWidget {
  @override
  _FaceBookFeedState createState() => _FaceBookFeedState();
}

class _FaceBookFeedState extends State<FaceBookFeed> {

  List<int>ids=[];
  TextStyle _hashTag=TextStyle(color: Colors.orange,);

  @override
  void initState() {
    super.initState();
    ids=[0,4,5,10];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "فيسبوك",
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder
        (
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _drawHeader(position),
                  _drawTitile(),
                  _drawHashTag(),
                  _drawBody(),
                  _drawFooter(),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }
  Widget _drawHeader(int position) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Transform.translate(
                offset: Offset(12,0),
                child: Text(
                  "25",
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                )),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                setState(() {
                  if(ids.contains(position)){ids.remove(position);}else{ids.add(position);}

                });
              },
              color: (ids.contains(position))?Colors.red:Colors.grey.shade400,
            ),

          ],
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "أحمد إبراهيم",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 8,
                  width: 3,
                ),
                Text(
                  "Fri, 12 May 2017 * 14.30",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
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
        ),
      ],
    );
  }

  Widget _drawTitile() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0,right: 24,left: 16),
      child: Text("هنا سنتكلم عن مستقبل الروبوتات",style: TextStyle(
        color: Colors.grey.shade900,

      ),),
    );
  }

  Widget _drawHashTag() {
    return Container(
      child: Wrap(
        children: [
          TextButton(onPressed: (){}, child: Text("#Advance",style: _hashTag,)),
          TextButton(onPressed: (){}, child: Text("#نصائح",style: _hashTag,)),
        ],
      ),
    );
  }

  Widget _drawBody() {
    return Padding(
      padding: const EdgeInsets.only(bottom :16.0),
      child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.25,
          child: Image(image: ExactAssetImage('assets/images/shop.jpg'),fit : BoxFit.cover)),
    );
  }

  Widget _drawFooter() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text("25 Comment",style: _hashTag,)),
        Row(
          children: [
            TextButton(
              child:  Text('مشاركة',style: _hashTag,),
              onPressed: () {
                /* ... */
              },
            ),
            TextButton(
              child:  Text('فتح',style: _hashTag,),
              onPressed: () {
                /* ... */
              },
            ),
          ],
        )
      ],
    );
  }
}
