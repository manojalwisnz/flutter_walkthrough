import 'package:flutter/material.dart';
import './page_view_indicator.dart';
import './model.dart';
import 'package:getwidget/getwidget.dart';

class WalkthroughPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: WalkthroughPageBody(),
    );
  }
}

class WalkthroughPageBody extends StatefulWidget {
  WalkthroughPageBody({Key key}) : super(key: key);

  @override
  WalkthroughPageBodyState createState() => WalkthroughPageBodyState();
}

class WalkthroughPageBodyState extends State<WalkthroughPageBody> {
  String textHolder = 'NEXT';
  dynamic curentPageIndex = 0;
  PageController _pageController;
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
  }

  void _pageListener() {
    if (_pageController.hasClients) {
      double page = _pageController.page ?? _pageController.initialPage;
      curentPageIndex = page.toInt();
      setState(() {
        if (page > 1.5) {
          setState(() {
            textHolder = 'DONE';
          });
        } else {
          setState(() {
            textHolder = 'NEXT';
          });
        }
      });
    }
  }

  changePage() {
    _pageController.animateToPage(curentPageIndex, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          itemBuilder: (BuildContext context, int index) {
            var assetImage = new AssetImage(pages[index].assetImagePath);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100.0),
                GFAvatar(
                  backgroundColor: Color(0xFFFFFFFF),
                  backgroundImage: assetImage,
                  radius: 300.0,
                  shape: GFAvatarShape.square,
                ),
              ],
            );
          },
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding:
                EdgeInsets.only(top: 655, left: 10, right: 10, bottom: 140),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: PageIndicators(
              pageController: _pageController,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 770, left: 10, right: 10, bottom: 70),
          child: FlatButton(
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 150.0),
            shape: Border.all(width: 2.0, color: Colors.blue),
            color: Colors.blue,
            onPressed: () => {_pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease)},
            child: Text('$textHolder'),
          ),
        ),
      ],
    );
  }
}

class PageIndicators extends StatelessWidget {
  final PageController pageController;

  const PageIndicators({Key key, this.pageController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: WalkthroughViewIndicator(
              controller: pageController,
              pageCount: 3,
              color: Colors.blue,
            )),
      ],
    );
  }
}
