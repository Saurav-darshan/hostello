import 'package:flutter/material.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/DetailScreen/DetailScreen.dart';

class FeaturedTemplate extends StatefulWidget {
  const FeaturedTemplate({Key? key}) : super(key: key);

  @override
  State<FeaturedTemplate> createState() => _FeaturedTemplateState();
}

class _FeaturedTemplateState extends State<FeaturedTemplate> {
  List<String> image = [
    "h1.jpeg",
    "h2.jpeg",
    "h3.webp",
    "h4.jpeg",
    "h5.jpeg",
    "h6.jpeg",
  ];
  List<String> rating = ["4.8", "4.3", "4.0", "4.6", "4.9", "5.0"];
  List<String> title = [
    "Zostel Patna",
    "Lichchavi Vihar Hostel",
    "Patna Youth Hostel",
    "Hotel City Home",
    "Rama Girls Hostel",
    "Taj Boys Hostel",
  ];
  List<String> address = [
    "Rajendra Nagar, Patna",
    "Frazer Road, Patna",
    "Phulwari Sharif, Patna",
    "Bailey Road, Patna",
    "Anisabad, Patna",
    "Boring Road, Patna",
  ];
  List<String> price = [
    "₹ 3000/ mo",
    "₹ 3500/ mo",
    "₹ 3900/ mo",
    "₹ 4000/ mo",
    "₹ 4700/ mo",
    "₹ 9000/ mo",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: image.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            print('${title[index]}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                          title: title[index],
                          image: image[index],
                          address: address[index],
                          price: price[index],
                          rating: rating[index],
                        )));
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
                    child: Image.asset(
                      "assets/${image[index]}",
                      fit: BoxFit.cover,
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
                        rating[index],
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
              //-----------------------\\
              Positioned(bottom: 50, right: 20, child: like()),
              Container(
                child: Positioned(
                  bottom: 50,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title[index],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        address[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        price[index],
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
  }
}

class like extends StatefulWidget {
  const like({super.key});

  @override
  State<like> createState() => _likeState();
}

class _likeState extends State<like> {
  var intx = 0;
  List<Icon> fav = [
    Icon(
      Icons.favorite_border_rounded,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.favorite,
      color: Colors.red,
      size: 30,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          intx = (intx == 0) ? 1 : 0;
        });
      },
      icon: fav[intx],
    );
  }
}
