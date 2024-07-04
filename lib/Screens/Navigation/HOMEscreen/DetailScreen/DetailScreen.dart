import 'package:flutter/material.dart';
import 'package:hostello/Modals/Data.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/DetailScreen/Enquiry_Screen.dart';

class DetailScreen extends StatelessWidget {
  final List<String> image;
  final String title;
  final String address;
  final String price;
  final String rating;
  final String overview;
  final List facilities;
  final String type;

  const DetailScreen(
      {Key? key,
      required this.image,
      required this.title,
      required this.address,
      required this.price,
      required this.rating,
      required this.overview,
      required this.facilities,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            child: Container(
              width: 300,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Price"),
                      Row(
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingScreen(
                                    hostelname: title,
                                    address: address,
                                    rating: rating,
                                    price: price,
                                    image: image[0],
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: Color.fromARGB(255, 0, 123, 255),
                      shape: StadiumBorder(),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      elevation: 10,
                      backgroundColor: Color.fromARGB(255, 0, 149, 255),
                    ),
                    child: const Text(
                      "Enquiry Now",
                      style: TextStyle(
                        color: Color.fromARGB(255, 243, 243, 243),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            //physics: PageScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Image.network(
                        image[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 60,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back_ios),
                            ),
                            Row(
                              children: [
                                //LikeButton(hostel: null,),
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(121, 187, 222, 251),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              type,
                              style: TextStyle(color: Colors.blue[800]),
                            ),
                          ),
                          SizedBox(width: 20),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              SizedBox(width: 5),
                              Text(
                                "$rating (0 reviews)",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blue[800],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: MediaQuery.sizeOf(context).width,
                        child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return buildAminities(facilities[index]);
                          },
                        ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                foregroundImage: AssetImage("assets/pp.jpg"),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Saurav Darshan",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text("Owner"),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Handle chat action
                                },
                                icon: Icon(
                                  Icons.chat,
                                  color: Colors.blue[500],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Handle phone action
                                },
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.blue[500],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 11),
                      Text(
                        "Overview",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        overview,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Facilities",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width - 10,
                        height: 200,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: facilities.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildCard(facilities[index]);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Gallery",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: ListView.builder(
                                        itemCount: image.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GalleryBottomSheetTemplate(
                                            image: image[index],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "See All",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        child: ListView.builder(
                          padding: EdgeInsets.only(right: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: image.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: GalleryTemplate(
                                images: image[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GalleryTemplate extends StatelessWidget {
  const GalleryTemplate({super.key, required this.images});
  final String images;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(images, fit: BoxFit.cover),
      ),
    );
  }
}

class GalleryBottomSheetTemplate extends StatelessWidget {
  const GalleryBottomSheetTemplate({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

Widget buildCard(String name) {
  IconData iconData = iconMap[name] ?? Icons.category;
  return Card(
    elevation: 4,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Icon(
            iconData,
            size: 40,
            color: Colors.blue,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildAminities(String name) {
  IconData iconData = iconMap[name] ?? Icons.category;
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(102, 187, 222, 251),
        ),
        child: Icon(
          iconData,
          color: Colors.blue[800],
        ),
      ),
      SizedBox(width: 10),
      Text(
        name,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      SizedBox(width: 15),
    ],
  );
}
