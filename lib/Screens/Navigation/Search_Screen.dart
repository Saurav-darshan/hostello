import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/DetailScreen/DetailScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _searchController = TextEditingController();
  Stream<List<QueryDocumentSnapshot>>? _searchResultsStream;
  bool _searchByName = true; // Initial toggle state

  @override
  void initState() {
    super.initState();
    _searchResultsStream = _firestore
        .collection('hostels')
        .snapshots()
        .map((snapshot) => snapshot.docs.toList());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String searchQuery) {
    if (searchQuery.length >= 1) {
      String searchQueryLower = searchQuery;
      print('Search query: $searchQueryLower');

      setState(() {
        if (_searchByName) {
          _searchResultsStream = _firestore
              .collection('hostels')
              .where('name', isGreaterThanOrEqualTo: searchQueryLower)
              .snapshots()
              .map((snapshot) => snapshot.docs.toList());
        } else {
          _searchResultsStream = _firestore
              .collection('hostels')
              .where('address', isGreaterThanOrEqualTo: searchQueryLower)
              .snapshots()
              .map((snapshot) => snapshot.docs.toList());
        }
      });
    } else {
      // Clear search results if query length is less than 3 characters
      setState(() {
        _searchResultsStream = _firestore
            .collection('hostels')
            .snapshots()
            .map((snapshot) => snapshot.docs.toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text('Search Hostels'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Search by Name'),
                Switch(
                  value: _searchByName,
                  onChanged: (value) {
                    setState(() {
                      _searchByName = value;
                      // Clear search results and text field on toggle change
                      _searchController.clear();
                      _performSearch('');
                    });
                  },
                ),
                Text('Search by Address'),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _searchController,
              onChanged: _performSearch,
              decoration: InputDecoration(
                labelText:
                    _searchByName ? 'Search by Name' : 'Search by Address',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _performSearch('');
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<QueryDocumentSnapshot>>(
                stream: _searchResultsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No results found'));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var hostel =
                          snapshot.data![index].data() as Map<String, dynamic>;
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: hostel['imageUrls'] != null &&
                                    hostel['imageUrls'].isNotEmpty
                                ? Image.network(
                                    hostel['imageUrls'][0],
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  )
                                : Icon(Icons.image,
                                    size: 50, color: Colors.grey[700]),
                          ),
                          title: Text(
                            hostel['name'] ?? 'No name provided',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(hostel['address'] ?? 'No address provided'),
                              Text(
                                '₹${hostel['rent']?.toString() ?? 'No rent provided'}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  title: hostel['name'] ?? 'No name provided',
                                  image: List<String>.from(
                                      hostel['imageUrls'] ?? []),
                                  address: hostel['address'] ??
                                      'No address provided',
                                  price: hostel['rent']?.toString() ??
                                      'No rent provided',
                                  rating: hostel['rating']?.toString() ?? 'N/A',
                                  overview: hostel['overview'] ??
                                      'No overview provided',
                                  facilities: List<String>.from(
                                      hostel['facilities'] ?? []),
                                  type: hostel['type'] ?? 'N/A',
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
            ),
          ],
        ),
      ),
    );
  }
}
