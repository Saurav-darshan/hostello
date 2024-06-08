import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hostello/Admin/Admin_login.dart';
import 'package:hostello/Colors/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String? finalloginDetail;
  void initState() {
    super.initState();
    isLogin().whenComplete(() async {
      Timer(Duration(seconds: 1), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Admin_LoginScreen()));
      });
    });
  }

  Future isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var obtained_detail = sp.getString('isLogin');
    setState(() {
      finalloginDetail = obtained_detail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ccolor.p1,
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 2,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  color: Ccolor.p3,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(500),
                  )),
            ),
            Align(
                alignment: Alignment(0, -.2),
                child: Image.asset("assets/logo.png")),
            Align(
              alignment: Alignment(0, .48),
              child: CircularProgressIndicator(color: Ccolor.p4),
            )
          ],
        ),
      ),
    );
  }
}
