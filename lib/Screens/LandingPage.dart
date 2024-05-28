import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/FavScreen/Fav_Screen.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/HomeScreen.dart';
import 'package:hostello/Screens/Navigation/Message_Screen.dart';
import 'package:hostello/Screens/Navigation/Profile/Profile_Screen.dart';
import 'package:hostello/Screens/Navigation/Search_Screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _page = 2;
  List<Widget> Widgetlist = [
    Fav_Screen(),
    //Notification_templete(),
    //Grid_templete(),
    Search_Screen(),
    HomeScreen(),
    Message_Screen(),
    Profile_Screen()
  ];

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            index: _page,
            key: _bottomNavigationKey,
            backgroundColor: Colors.white,
            color: const Color.fromARGB(255, 60, 156, 236),
            animationCurve: Curves.linearToEaseOut,
            items: <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              Icon(
                Icons.message_rounded,
                color: Colors.white,
              ),
              Icon(
                Icons.person,
                color: Colors.white,
              ),
            ],
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
          ),
          body: Stack(
            children: [
              IndexedStack(
                children: Widgetlist,
                index: _page,
              )
            ],
          )),
    );
  }
}
