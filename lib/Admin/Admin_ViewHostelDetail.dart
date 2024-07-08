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

  Future<void> _toggleLiveStatus(String hostelId, bool currentStatus) async {
    try {
      await _firestore.collection('hostels').doc(hostelId).update({
        'isLive': currentStatus,
      });
    } catch (e) {
      print('Error updating live status: $e');
    }
  }

  Future<void> _toggleFeaturedStatus(
      String hostelId, bool currentStatus) async {
    try {
      await _firestore.collection('hostels').doc(hostelId).update({
        'isFeatured': currentStatus,
      });
    } catch (e) {
      print('Error updating featured status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ccolor.p1,
      appBar: AppBar(
        backgroundColor: Ccolor.p1,
        title: Text(
          'Hostel Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('hostels').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No hostels found',
                style: TextStyle(color: Colors.black54),
              ),
            );
          }

          var hostels = snapshot.data!.docs;

          return ListView.builder(
            itemCount: hostels.length,
            itemBuilder: (context, index) {
              var hostel = hostels[index].data() as Map<String, dynamic>;
              var hostelId = hostels[index].id;

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 6,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Ccolor.p2, Ccolor.p3],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: hostel['imageUrls'] != null &&
                                    hostel['imageUrls'].isNotEmpty
                                ? Image.network(
                                    hostel['imageUrls'][0],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey[300],
                                    child: Icon(
                                      Icons.image,
                                      size: 50,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hostel['name'] ?? 'No name provided',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.white, size: 16),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        hostel['address'] ??
                                            'No address provided',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                          fontFamily: 'Montserrat',
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.money,
                                        color: Colors.white, size: 16),
                                    SizedBox(width: 5),
                                    Text(
                                      'Rent: ${hostel['rent']?.toString() ?? 'No rent provided'}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.category,
                                        color: Colors.white, size: 16),
                                    SizedBox(width: 5),
                                    Text(
                                      'Type: ${hostel['type'] ?? 'No type provided'}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.info,
                                        color: Colors.white, size: 16),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        'Overview: ${hostel.containsKey('overview') ? hostel['overview'] : 'No overview provided'}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                          fontFamily: 'Montserrat',
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.featured_play_list,
                                        color: Colors.white, size: 16),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        'Facilities: ${(hostel['facilities'] != null && hostel['facilities'].isNotEmpty) ? hostel['facilities'].join(', ') : 'No facilities provided'}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                          fontFamily: 'Montserrat',
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Live:',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Switch(
                                value: hostel['isLive'] ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    _toggleLiveStatus(hostelId, value);
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Featured:',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Switch(
                                value: hostel['isFeatured'] ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    _toggleFeaturedStatus(hostelId, value);
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
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
