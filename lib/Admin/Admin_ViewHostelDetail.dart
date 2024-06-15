import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostello/colors/colors.dart';

class Admin_ViewHostelDetails extends StatefulWidget {
  const Admin_ViewHostelDetails({super.key});
  @override
  State<Admin_ViewHostelDetails> createState() =>
      _AdminViewHostelDetailsState();
}

class _AdminViewHostelDetailsState extends State<Admin_ViewHostelDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ccolor.p1,
      appBar: AppBar(
        backgroundColor: Ccolor.p1,
        title: Text('Hostel Details'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('hostels').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No hostels found'));
          }

          var hostels = snapshot.data!.docs;

          return ListView.builder(
            itemCount: hostels.length,
            itemBuilder: (context, index) {
              var hostel = hostels[index].data() as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: hostel['imageUrls'] != null &&
                          hostel['imageUrls'].isNotEmpty
                      ? Image.network(
                          hostel['imageUrls'][0],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.image),
                  title: Text(hostel['name'] ?? 'No name provided'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Address: ${hostel['address'] ?? 'No address provided'}'),
                      Text(
                          'Rent: ${hostel['rent']?.toString() ?? 'No rent provided'}'),
                      Text('Type: ${hostel['type'] ?? 'No type provided'}'),
                      Text(
                          'Overview: ${hostel.containsKey('overview') ? hostel['overview'] : 'No overview provided'}'),
                      Text(
                          'Facilities: ${(hostel['facilities'] != null && hostel['facilities'].isNotEmpty) ? hostel['facilities'].join(', ') : 'No facilities provided'}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
