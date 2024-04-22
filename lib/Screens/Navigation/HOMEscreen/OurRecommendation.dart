import 'package:flutter/material.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/Templete/Grid_templete.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/Templete/menu_templete.dart';

class OurRecommendation extends StatefulWidget {
  const OurRecommendation({super.key});

  @override
  State<OurRecommendation> createState() => _OurRecommendationState();
}

class _OurRecommendationState extends State<OurRecommendation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OUR Recommendation",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w800),
        ),
        centerTitle: false,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [
          SizedBox(height: 50, child: Menu_templete()),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 170,
              child: Grid_templete()),
        ],
      ),
    );
  }
}
