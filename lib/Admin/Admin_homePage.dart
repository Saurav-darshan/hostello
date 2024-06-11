import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hostello/Colors/Colors.dart';

class Admin_HomeScreen extends StatefulWidget {
  const Admin_HomeScreen({super.key});

  @override
  State<Admin_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Admin_HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Ccolor.p1,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Ccolor.p1,
              leading: Padding(
                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ProfileScreen(),
                    //     ));
                  },
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    foregroundImage: AssetImage("assets/pp.jpg"),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: IconButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => NotificationScreen(),
                        //     ));
                      },
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Ccolor.p3))),
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
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: <Widget>[
                      _buildCard(
                          'Total Hostels', '25', Icons.hotel, Colors.blue),
                      _buildCard(
                          'Bookings Today', '7', Icons.book, Colors.green),
                      _buildCard(
                          'Available Rooms', '120', Icons.room, Colors.orange),
                      _buildCard(
                          'Pending Requests', '3', Icons.pending, Colors.red),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Carousel_templete()
              ],
            )));
  }
}
//----------------------------Carousel templete---------------->>

class Carousel_templete extends StatefulWidget {
  const Carousel_templete({super.key});

  @override
  State<Carousel_templete> createState() => _Carousel_templeteState();
}

class _Carousel_templeteState extends State<Carousel_templete> {
  final List<String> imageUrls = [
    'https://gos3.ibcdn.com/img-1697631817.jpg',
    'https://animationvisarts.com/wp-content/uploads/2017/05/airbnb-banner.jpg',
    'https://gos3.ibcdn.com/img-1697631817.jpg',
    'https://animationvisarts.com/wp-content/uploads/2017/05/airbnb-banner.jpg',
    'https://gos3.ibcdn.com/img-1697631817.jpg',
    'https://animationvisarts.com/wp-content/uploads/2017/05/airbnb-banner.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 100.0,
        // enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 4 / 3,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1,
      ),
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

Card _buildCard(String title, String count, IconData icon, Color color) {
  return Card(
    color: Ccolor.p1,
    elevation: 4,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 50, color: color),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            count,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
