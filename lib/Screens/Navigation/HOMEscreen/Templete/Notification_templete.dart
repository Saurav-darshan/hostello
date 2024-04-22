import 'package:flutter/material.dart';

class Notification_templete extends StatefulWidget {
  const Notification_templete({super.key});

  @override
  State<Notification_templete> createState() => _Notification_templeteState();
}

class _Notification_templeteState extends State<Notification_templete> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue[100]),
                child: Icon(Icons.notifications),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Booking Succesful !",
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "22 Apl ,2024 | 8:46 AM",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Congratulations! You have successfully booked a houses for 1 Month for ₹ 3000. Enjoy the services!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
