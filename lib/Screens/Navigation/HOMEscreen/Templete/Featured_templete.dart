import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostello/Modals/like_provider.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/DetailScreen/DetailScreen.dart';
import 'package:provider/provider.dart';

class FeaturedTemplate extends StatefulWidget {
  const FeaturedTemplate({Key? key}) : super(key: key);

  @override
  State<FeaturedTemplate> createState() => _FeaturedTemplateState();
}

class _FeaturedTemplateState extends State<FeaturedTemplate> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('hostels')
          .where('isFeatured', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
              child: Text('No featured hostels found',
                  style: TextStyle(color: Colors.black54)));
        }

        var hostels = snapshot.data!.docs;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
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
              child: Stack(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: const Color.fromARGB(255, 215, 215, 215),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: hostelData['imageUrls'] != null &&
                                hostelData['imageUrls'].isNotEmpty
                            ? Image.network(
                                hostelData['imageUrls'][0],
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: Colors.grey[300],
                                child: Icon(Icons.image,
                                    size: 50, color: Colors.grey[700]),
                              ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, top: 5),
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Color.fromARGB(68, 0, 0, 0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 20,
                    child: Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 50, right: 20, child: LikeButton(hostel: hostel)),
                  Container(
                    child: Positioned(
                      bottom: 50,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hostelData['name'] ?? 'No name provided',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            hostelData['address'] ?? 'No address provided',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '₹${hostelData['rent']?.toString() ?? 'No rent provided'}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
            color: isLiked ? Colors.red : Colors.white,
            size: 30,
          ),
        );
      },
    );
  }
}
