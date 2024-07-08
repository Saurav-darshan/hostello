import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostello/Colors/Colors.dart';

class Admin_ViewEnquiriesScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ccolor.p1,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '🔔 Hostel Enquiries 🔔',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            //color: Colors.white,
          ),
        ),
        backgroundColor: Ccolor.p1,
      ),
      body: Column(
        children: [
          _buildSummarySection(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('enquiries').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No enquiries found'));
                }

                // Group enquiries by hostel name
                Map<String, List<QueryDocumentSnapshot>> hostelEnquiries = {};
                for (var doc in snapshot.data!.docs) {
                  var data = doc.data() as Map<String, dynamic>;
                  String hostelName = data['hostelname'] ?? 'Unknown Hostel';
                  if (!hostelEnquiries.containsKey(hostelName)) {
                    hostelEnquiries[hostelName] = [];
                  }
                  hostelEnquiries[hostelName]!.add(doc);
                }

                return ListView.builder(
                  itemCount: hostelEnquiries.keys.length,
                  itemBuilder: (context, index) {
                    String hostelName = hostelEnquiries.keys.elementAt(index);
                    List<QueryDocumentSnapshot> enquiries =
                        hostelEnquiries[hostelName]!;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ExpansionTile(
                          backgroundColor: Colors.white,
                          title: Text(
                            hostelName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Ccolor.p4,
                            ),
                          ),
                          children: enquiries.map((doc) {
                            var data = doc.data() as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      data['name'] ?? 'No name provided',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8),
                                        Text(
                                          'Mobile: ${data['mobileNo'] ?? 'No mobile provided'}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        Text(
                                          'Email: ${data['email'] ?? 'No email provided'}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        Text(
                                          'Gender: ${data['gender'] ?? 'No gender provided'}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        Text(
                                          'Enquiry Date: ${data['timestamp'] != null ? (data['timestamp'] as Timestamp).toDate().toString() : 'No date provided'}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        Text(
                                          'Status: ${data['status'] ?? 'No status provided'}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: data['status'] == 'approved'
                                                ? Colors.green
                                                : data['status'] == 'rejected'
                                                    ? Colors.red
                                                    : Colors.orange,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: data['status'] == 'pending'
                                          ? [
                                              IconButton(
                                                icon: Icon(Icons.check_circle,
                                                    color: Colors.green),
                                                onPressed: () {
                                                  _respondToEnquiry(doc.id);
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.cancel,
                                                    color: Colors.red),
                                                onPressed: () {
                                                  _rejectEnquiry(doc.id);
                                                },
                                              ),
                                            ]
                                          : [],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey[300],
                                    thickness: 1,
                                    indent: 16,
                                    endIndent: 16,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('enquiries').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var total = snapshot.data!.docs.length;
        var approved = snapshot.data!.docs
            .where((doc) => doc['status'] == 'approved')
            .length;
        var pending = snapshot.data!.docs
            .where((doc) => doc['status'] == 'pending')
            .length;
        var rejected = snapshot.data!.docs
            .where((doc) => doc['status'] == 'rejected')
            .length;
        var today = snapshot.data!.docs.where((doc) {
          var timestamp = doc['timestamp'] as Timestamp;
          var date = timestamp.toDate();
          var now = DateTime.now();
          return date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;
        }).length;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Ccolor.p4,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Total Enquiries: $total'),
                  Text('Approved Enquiries: $approved'),
                  Text('Pending Enquiries: $pending'),
                  Text('Rejected Enquiries: $rejected'),
                  Text('Today\'s Enquiries: $today'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _respondToEnquiry(String enquiryId) {
    // Implement your response logic here
    // For example, you can update the status of the enquiry in Firestore
    _firestore.collection('enquiries').doc(enquiryId).update({
      'status': 'approved',
      'responseDate': FieldValue.serverTimestamp(),
    }).then((_) {
      print('Enquiry approved successfully');
    }).catchError((error) {
      print('Failed to approve enquiry: $error');
    });
  }

  void _rejectEnquiry(String enquiryId) {
    // Implement your rejection logic here
    // For example, you can update the status of the enquiry in Firestore
    _firestore.collection('enquiries').doc(enquiryId).update({
      'status': 'rejected',
      'responseDate': FieldValue.serverTimestamp(),
    }).then((_) {
      print('Enquiry rejected successfully');
    }).catchError((error) {
      print('Failed to reject enquiry: $error');
    });
  }
}
