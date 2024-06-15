import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hostello/Admin/Admin_AddHostelDetail.dart';
import 'package:hostello/Admin/Admin_ViewHostelDetail.dart';
import 'package:hostello/Admin/Admin_homePage.dart';
import 'package:hostello/Colors/Colors.dart';

class Admin_LandingScreen extends StatefulWidget {
  const Admin_LandingScreen({super.key});

  @override
  State<Admin_LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<Admin_LandingScreen> {
  int _page = 0;
  List<Widget> Widgetlist = [
    Admin_HomeScreen(),
    Admin_AddHostelDetail(),
    Admin_ViewHostelDetails()
  ];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ccolor.p1,
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        index: _page,
        key: _bottomNavigationKey,
        backgroundColor: Ccolor.p1,
        color: Ccolor.p4,
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
      ),
    );
  }
}
