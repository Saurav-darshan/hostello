import 'package:flutter/material.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/DetailScreen/Enquiry_Screen.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/Templete/Featured_templete.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.address,
      required this.price,
      required this.rating});
  final String image;
  final String title;
  final String address;
  final String price;
  final String rating;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
                            Text(
                              "Price",
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.price,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingScreen(),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Color.fromARGB(255, 0, 123, 255),
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 50),
                            elevation: 10,
                            backgroundColor: Color.fromARGB(255, 0, 149, 255),
                          ),
                          child: const Text(
                            "Enquiry Now",
                            style: TextStyle(
                                color: Color.fromARGB(255, 243, 243, 243),
                                fontSize: 20),
                          ),
                        ),
                      ]))),
          body: SingleChildScrollView(
            physics: PageScrollPhysics(),
            child: Column(
              children: [
                Container(
                  child: Stack(children: [
                    Container(
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Image.asset(
                          "assets/${widget.image}",
                          fit: BoxFit.cover,
                        )),
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
                                child: Icon(Icons.arrow_back_ios)),
                            Row(
                              children: [
                                like(),
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          121, 187, 222, 251),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Hostel",
                                    style: TextStyle(color: Colors.blue[800]),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${widget.rating} (1971 reviews)",
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
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Amminites_Icon(),
                                Amminites_Icon(),
                                Amminites_Icon()
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        foregroundImage:
                                            AssetImage("assets/pp.jpg"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Saurav Darshan",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              wordSpacing: 2.0),
                                        ),
                                        Text("Owner")
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: IconButton(
                                          onPressed: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) => ,
                                            //     ));
                                          },
                                          icon: Icon(
                                            Icons.chat,
                                            color: Colors.blue[500],
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.transparent))),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: IconButton(
                                          onPressed: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) => ,
                                            //     ));
                                          },
                                          icon: Icon(
                                            Icons.phone,
                                            color: Colors.blue[500],
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.transparent))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Text(
                              "Overview",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                            Text(
                              "lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non neque vitae justo consequat pretium. Nullam ac felis ut velit condimentum posuere sed non justo. Aliquam erat volutpat. Integer eu ligula euismod, interdum lacus ut, tempus mi. Vestibulum et libero vestibulum, faucibus dolor a, lobortis arcu. ",
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Facilities",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              width: MediaQuery.sizeOf(context).width - 10,
                              height: 200,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: 8,
                                itemBuilder: (BuildContext context, int index) {
                                  return _facilities_icon();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Gallery",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (Buildercontext) {
                                            return SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                  .height,
                                              child: ListView.builder(
                                                itemCount: 5,
                                                physics: PageScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return GalleryBottomSheet_Templete(
                                                    image: widget.image,
                                                  );
                                                },
                                              ),
                                            );
                                          });
                                    },
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              height: 120,
                              child: ListView.builder(
                                padding: EdgeInsets.only(right: 10),
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Gallery_templete(
                                      images: widget.image,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Amminites_Icon extends StatefulWidget {
  const Amminites_Icon({super.key});

  @override
  State<Amminites_Icon> createState() => _Amminites_IconState();
}

class _Amminites_IconState extends State<Amminites_Icon> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(102, 187, 222, 251)),
          child: Icon(
            Icons.bed,
            color: Colors.blue[800],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "8 Beds",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}

//--------------------> facillites icon grid templete <-----------------\\

class _facilities_icon extends StatefulWidget {
  const _facilities_icon({super.key});

  @override
  State<_facilities_icon> createState() => __facilities_iconState();
}

class __facilities_iconState extends State<_facilities_icon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(102, 187, 222, 251)),
          child: Icon(
            Icons.bed,
            size: 30,
            color: Colors.blue[800],
          ),
        ),
        Text(
          "8 Beds",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

//---------> Gallery Templete <-------------\\

class Gallery_templete extends StatefulWidget {
  const Gallery_templete({super.key, required this.images});
  final String images;

  @override
  State<Gallery_templete> createState() => _Gallery_templeteState();
}

class _Gallery_templeteState extends State<Gallery_templete> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        child: Image.asset("assets/${widget.images}", fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

//-------> Gallery Enlarge display tempelete <-------------\\

class GalleryBottomSheet_Templete extends StatefulWidget {
  const GalleryBottomSheet_Templete({super.key, required this.image});
  final String image;

  @override
  State<GalleryBottomSheet_Templete> createState() =>
      _GalleryBottomSheet_TempleteState();
}

class _GalleryBottomSheet_TempleteState
    extends State<GalleryBottomSheet_Templete> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 10,
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          "assets/${widget.image}",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
