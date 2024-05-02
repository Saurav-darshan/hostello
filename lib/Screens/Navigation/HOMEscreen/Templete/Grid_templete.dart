import 'package:flutter/material.dart';

class Grid_templete extends StatefulWidget {
  const Grid_templete({super.key});

  @override
  State<Grid_templete> createState() => _Grid_templeteState();
}

class _Grid_templeteState extends State<Grid_templete> {
  List<String> image = [
    "h1.jpeg",
    "h2.jpeg",
    "h3.webp",
    "h4.jpeg",
    "h5.jpeg",
    "h6.jpeg",
    "h7.jpeg",
    "h8.jpeg",
    "h9.jpeg",
  ];
  List<String> rating = [
    "4.8",
    "4.3",
    "4.0",
    "4.6",
    "4.9",
    "5.0",
    "3.7",
    "3.9",
    "3.5"
  ];
  List<String> title = [
    "Zostel Patna",
    "Lichchavi Vihar Hostel",
    "Patna Youth Hostel",
    "Hotel City Home",
    "Rama Girls Hostel",
    "Taj Boys Hostel",
    "Ratna Girls Hostel",
    "Sudha Girls Hostel",
    "Jaya Girls Hostel",
  ];
  List<String> address = [
    "Rajendra Nagar, Patna",
    "Frazer Road, Patna",
    "Phulwari Sharif , Patna",
    "Bailey Road , Patna",
    "Anisabad , patna",
    "Boring Road , Patna",
    "Gandhi maidan , Patna",
    "Phulwari Sharif , Patna",
    "Phulwari Sharif , Patna",
  ];
  List<String> price = [
    "₹ 3000/ mo",
    "₹ 3500/ mo",
    "₹ 3900/ mo",
    "₹ 4000/ mo",
    "₹ 4700/ mo",
    "₹ 9000/ mo",
    "₹ 5900/ mo",
    "₹ 900/ mo",
    "₹ 6900/ mo",
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.horizontal,
        physics: ScrollPhysics(parent: RangeMaintainingScrollPhysics()),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5),
        itemCount: image.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
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
                            child: Image.asset(
                              "assets/${image[index]}",
                              fit: BoxFit.cover,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 15,
                                ),
                                Text(
                                  rating[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blue[800],
                                      fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      title[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      address[index],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price[index],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                        Fav_check()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class Fav_check extends StatefulWidget {
  const Fav_check({super.key});

  @override
  State<Fav_check> createState() => _Fav_checkState();
}

class _Fav_checkState extends State<Fav_check> {
  @override
  List<Icon> fav = [
    Icon(
      Icons.favorite_border_rounded,
      color: Colors.blue,
      size: 30,
    ),
    Icon(
      Icons.favorite,
      color: Colors.red,
      size: 30,
    )
  ];
  var intx = 0;
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (intx == 0) {
          setState(() {
            intx = 1;
          });
        } else {
          setState(() {
            intx = 0;
          });
        }
      },
      child: fav[intx],
    );
  }
}
