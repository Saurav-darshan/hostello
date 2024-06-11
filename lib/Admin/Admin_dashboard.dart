import 'package:flutter/material.dart';
import 'package:hostello/colors/colors.dart';

class Admin_DashboardOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: <Widget>[
          _buildCard('Total Hostels', '25', Icons.hotel, Colors.blue),
          _buildCard('Bookings Today', '7', Icons.book, Colors.green),
          _buildCard('Available Rooms', '120', Icons.room, Colors.orange),
          _buildCard('Pending Requests', '3', Icons.pending, Colors.red),
        ],
      ),
    );
  }

  Card _buildCard(String title, String count, IconData icon, Color color) {
    return Card(
      color: Ccolor.p3,
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
}
