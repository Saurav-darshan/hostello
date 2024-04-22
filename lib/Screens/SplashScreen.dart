import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hostello/Screens/LandingPage.dart';
import 'package:hostello/Screens/Login/LoginScreen.dart';
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
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    finalloginDetail == null ? LoginScreen() : LandingPage()));
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
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/bg1.png",
                // color: Color.fromARGB(244, 25, 146, 245),
                fit: BoxFit.fitHeight,
              ),
              color: Colors.white,
            ),
            Align(
              alignment: Alignment(0, -.12),
              child: Image.asset(
                "assets/logo.png",
                scale: 1,
              ),
            ),
            Align(
              alignment: Alignment(0, .48),
              child: CircularProgressIndicator(
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            )
          ],
        ),
      ),
    );
  }
}
