import 'package:flutter/material.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/Templete/Notification_templete.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w800),
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz_outlined))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Notification_templete();
          },
        ),
      ),
    );
  }
}
