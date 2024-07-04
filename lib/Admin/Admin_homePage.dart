import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostello/Colors/Colors.dart';

class Admin_HomeScreen extends StatefulWidget {
  const Admin_HomeScreen({super.key});

  @override
  State<Admin_HomeScreen> createState() => _Admin_HomeScreenState();
}

class _Admin_HomeScreenState extends State<Admin_HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  Stream<DocumentSnapshot> getUserData() {
    if (_currentUser != null) {
      return _firestore.collection('users').doc(_currentUser!.uid).snapshots();
    }
    return Stream.empty();
  }

  Stream<int> getTotalHostels() {
    return _firestore
        .collection('hostels')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Stream<int> getTotalEnquiries() {
    return _firestore
        .collection('enquiries')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Stream<int> getTodayEnquiries() {
    DateTime today = DateTime.now();
    DateTime startOfDay = DateTime(today.year, today.month, today.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1));

    return _firestore
        .collection('enquiries')
        .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
        .where('timestamp', isLessThan: endOfDay)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Stream<int> getRejectedEnquiries() {
    return _firestore
        .collection('enquiries')
        .where('status', isEqualTo: 'rejected')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

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
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
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
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                },
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Ccolor.p3)),
              ),
            )
          ],
          title: StreamBuilder<DocumentSnapshot>(
            stream: getUserData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Column(
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
                      "Loading...",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                );
              }

              var userDocument = snapshot.data!;
              return Column(
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
                    userDocument['username'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              );
            },
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
                  _buildStreamCard('Total Hostels', getTotalHostels(),
                      Icons.hotel, Colors.blue),
                  _buildStreamCard('Total Enquiries', getTotalEnquiries(),
                      Icons.book, Colors.green),
                  _buildStreamCard('Today\'s Enquiries', getTodayEnquiries(),
                      Icons.today, Colors.orange),
                  _buildStreamCard('Rejected Enquiries', getRejectedEnquiries(),
                      Icons.pending, Colors.red),
                ],
              ),
            ),
            SizedBox(height: 10),
            Carousel_templete(),
          ],
        ),
      ),
    );
  }

  Card _buildStreamCard(
      String title, Stream<int> stream, IconData icon, Color color) {
    return Card(
      color: Ccolor.p1,
      elevation: 4,
      child: StreamBuilder<int>(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 40, color: color),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  snapshot.data.toString(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

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
              decoration: BoxDecoration(color: Colors.amber),
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
