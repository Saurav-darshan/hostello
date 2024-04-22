import 'package:flutter/material.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/NotificationScreen.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/OurRecommendation.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/Templete/Featured_templete.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/Templete/Grid_templete.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/Templete/menu_templete.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          leading: Padding(
            padding: EdgeInsets.only(left: 10),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              foregroundImage: AssetImage("assets/pp.jpg"),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                        ));
                  },
                  icon: Icon(Icons.notifications),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(158, 232, 233, 232)))),
            )
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning 👋",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Saurav Darshan",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              InkWell(
                onTap: () {},
                child: Container(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(40, 158, 158, 158),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [Icon(Icons.search), Text('Search')],
                      ),
                      Icon(Icons.format_list_bulleted_sharp)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Featured",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.2,
                child: FeaturedTemplate(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Our Recommendation",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OurRecommendation(),
                            ));
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50, child: Menu_templete()),
              SizedBox(height: 650, child: Grid_templete()),
            ]),
          ),
        ),
      ),
    );
  }
}
