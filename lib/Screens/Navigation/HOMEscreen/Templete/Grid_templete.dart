import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostello/Modals/like_provider.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/DetailScreen/DetailScreen.dart';
import 'package:provider/provider.dart';

class GridTemplate extends StatefulWidget {
  const GridTemplate({super.key});

  @override
  State<GridTemplate> createState() => _GridTemplateState();
}

class _GridTemplateState extends State<GridTemplate> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('hostels').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No hostels found'));
        }

        var hostels = snapshot.data!.docs;

        return GridView.builder(
          scrollDirection: Axis.horizontal,
          physics: ScrollPhysics(parent: RangeMaintainingScrollPhysics()),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
          ),
          itemCount: hostels.length,
          itemBuilder: (BuildContext context, int index) {
            var hostel = hostels[index];
            var hostelData = hostel.data() as Map<String, dynamic>;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      title: hostelData['name'] ?? 'No name provided',
                      image: List<String>.from(hostelData['imageUrls'] ?? []),
                      address: hostelData['address'] ?? 'No address provided',
                      price:
                          hostelData['rent']?.toString() ?? 'No rent provided',
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
              child: Container(
                height: 250,
                width: 200,
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: MediaQuery.of(context).size.width / 2.2,
                              margin: EdgeInsets.only(bottom: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child:
                                    hostelData['imageUrls']?.isNotEmpty == true
                                        ? Image.network(
                                            hostelData['imageUrls'][0],
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            color: Colors.grey,
                                            child: Icon(
                                              Icons.image,
                                              size: 50,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: Container(
                                width: 50,
                                height: 20,
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 15,
                                    ),
                                    Text(
                                      hostelData['rating']?.toString() ?? 'N/A',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.blue[800],
                                        fontSize: 13,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          hostelData['name'] ?? 'No name provided',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          hostelData['address'] ?? 'No address provided',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹${hostelData['rent']?.toString() ?? 'No rent provided'}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            LikeButton(hostel: hostel)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class LikeButton extends StatefulWidget {
  final DocumentSnapshot hostel;

  const LikeButton({super.key, required this.hostel});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LikedHostelsProvider>(
      builder: (context, likedHostelsProvider, child) {
        bool isLiked = likedHostelsProvider.isLiked(widget.hostel.id);
        return IconButton(
          onPressed: () {
            if (isLiked) {
              likedHostelsProvider.removeHostel(widget.hostel.id);
            } else {
              likedHostelsProvider.addHostel(widget.hostel);
            }
          },
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border_rounded,
            color: isLiked ? Colors.red : Colors.black,
            size: 30,
          ),
        );
      },
    );
  }
}
