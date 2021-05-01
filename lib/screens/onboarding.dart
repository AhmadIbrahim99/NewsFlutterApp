import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'file:///D:/lab/Documents/flutter_app/lib/pagemodel.dart';
import 'homescreen.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<PageModel> pages = List<PageModel>();

  List<Color> col = [
    Colors.blueGrey,
    Colors.black,
    Colors.brown,
    Colors.deepPurple
  ];
  List<IconData> _icons = [
    Icons.shopping_bag_outlined,
    Icons.shopping_bag,
    Icons.shop,
    Icons.shop_two
  ];

  List<String> _title = [
    "!مرحباً",
    "!شاشة",
    "شاشة",
    "شاشة",
  ];
  List<String> _descr = [
    "تصفح التطبيق وتنقل في المتجر الإلكتروني وأحصل على ما تريد",
    "تصفح التطبيق وتنقل في المتجر الإلكتروني وأحصل على ما تريد",
    "تصفح التطبيق وتنقل في المتجر الإلكتروني وأحصل على ما تريد",
    "تصفح التطبيق وتنقل في المتجر الإلكتروني وأحصل على ما تريد",
  ];
  TextStyle _textStyle =
      TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold);
  TextStyle _textStyleWC =
      TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold);
  TextStyle _textStyleGS = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1);

  //Center for text
  TextAlign _textAlign = TextAlign.center;

  //Center for Icons
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.center;
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.center;
  PageController _pageController = new PageController();

  void _addPage() {
    for (int i = 0; i < 4; i++) {
      pages.add(PageModel(_title[i], _descr[i], col[i], _icons[i]));
    }
    /*  pages.add(PageModel("!مرحباً", "تصفح التطبيق وتنقل في المتجر الإلكتروني وأحصل على ما تريد",
        Colors.blueGrey, Icons.shopping_bag_outlined,));
    pages.add(PageModel("الشاشة الثانية", "الوصف", Colors.black, Icons.shopping_bag));
    pages.add(PageModel("الشاشة الثالثة", "الوصف الخاص بالشاشة", Colors.deepPurpleAccent, Icons.shop));*/
  }

  @override
  Widget build(BuildContext context) {
    //addPage
    _addPage();
    final int numberOfPage = pages.length;
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    color: pages[index].color,
                    //هنا كيفية تزيين الخلفية بصورة
                    /*

                  decoration: BoxDecoration(
                        image: DecorationImage(
                      image: ExactAssetImage('assets/images/NameOfImage.png'),
                      fit: BoxFit.cover,
                    )),*/
                  ),
                  Column(
                    crossAxisAlignment: _crossAxisAlignment,
                    mainAxisAlignment: _mainAxisAlignment,
                    children: [
                      Transform.translate(
                        child: Icon(
                          pages[index].iconData,
                          size: 150,
                          color: Colors.white,
                        ),
                        offset: Offset(0, -100),
                      ),
                      Text(
                        pages[index].title,
                        textAlign: _textAlign,
                        style: _textStyleWC,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 40, right: 40, top: 14),
                        child: Text(
                          pages[index].desc,
                          textAlign: _textAlign,
                          style: _textStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            itemCount: numberOfPage,
            onPageChanged: (index) {},
          ),
          Transform.translate(
            offset: Offset(0, 175),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: _mainAxisAlignment,
                children: [
                  Container(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: numberOfPage,
                      effect: WormEffect(
                        dotColor: Colors.white,
                        activeDotColor: Colors.red,
                      ),
                      onDotClicked: (index) => _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInCubic
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 24,
                left: 16,
                right: 16,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.red.shade900,
                  child: Text(
                    "GET STARTED",
                    style: _textStyleGS,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        updateseen();
                        return HomeScreen();
                      },
                    ));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> updateseen() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setBool('seen',true);
    print("seen");
  }
}

/*
  List<Widget>_drawPage(){
    List<Widget> widgets= List<Widget>();
    for(var i in pages){
      widgets.add(_drawCircle(Colors.white));
      }
return widgets;
  }
Widget _drawCircle(Color color){
  return Container(
    margin: EdgeInsets.only(right: 8) ,
    width: 10,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
  );
}
*/
