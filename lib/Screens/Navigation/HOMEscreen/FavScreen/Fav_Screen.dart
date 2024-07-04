import 'package:flutter/material.dart';
import 'package:hostello/Modals/like_provider.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/DetailScreen/DetailScreen.dart';
import 'package:provider/provider.dart';

class LikedHostelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Hostels'),
      ),
      body: Consumer<LikedHostelsProvider>(
        builder: (context, likedHostelsProvider, child) {
          if (likedHostelsProvider.likedHostels.isEmpty) {
            return Center(
              child: Text('No liked hostels'),
            );
          }
          return ListView.builder(
            itemCount: likedHostelsProvider.likedHostels.length,
            itemBuilder: (context, index) {
              var hostel = likedHostelsProvider.likedHostels[index];
              var hostelData = hostel.data() as Map<String, dynamic>;

              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: hostelData['imageUrls'] != null &&
                            hostelData['imageUrls'].isNotEmpty
                        ? Image.network(
                            hostelData['imageUrls'][0],
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          )
                        : Icon(Icons.image, size: 50, color: Colors.grey[700]),
                  ),
                  title: Text(
                    hostelData['name'] ?? 'No name provided',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hostelData['address'] ?? 'No address provided'),
                      Text(
                        '₹${hostelData['rent']?.toString() ?? 'No rent provided'}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      likedHostelsProvider.removeHostel(hostel.id);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          title: hostelData['name'] ?? 'No name provided',
                          image:
                              List<String>.from(hostelData['imageUrls'] ?? []),
                          address:
                              hostelData['address'] ?? 'No address provided',
                          price: hostelData['rent']?.toString() ??
                              'No rent provided',
                          rating: hostelData['rating']?.toString() ?? 'N/A',
                          overview:
                              hostelData['overview'] ?? 'No overview provided',
                          facilities:
                              List<String>.from(hostelData['facilities'] ?? []),
                          type: hostelData['type'] ?? 'N/A',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
