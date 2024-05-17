import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selected_date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Card(
            surfaceTintColor: Colors.white,
            elevation: Checkbox.width,
            margin: EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.sizeOf(context).height / 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(
                              "assets/h6.jpeg",
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
                                  "4.5",
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
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Taj Boys\n Hostel",
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "kankarbagh patna",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "₹ 3000\n /mo",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
              surfaceTintColor: Colors.white,
              elevation: Checkbox.width,
              margin: EdgeInsets.all(10),
              child: Container(
                  height: MediaQuery.sizeOf(context).height / 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                                "Date:- ${selected_date.day}/ ${selected_date.month}/${selected_date.year}"),
                            IconButton(
                                onPressed: () async {
                                  final DateTime? dateTime =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: selected_date,
                                          firstDate: DateTime(1000),
                                          lastDate: DateTime(9999));
                                  if (dateTime != null) {
                                    setState(() {
                                      selected_date = dateTime;
                                    });
                                  }
                                },
                                icon: Icon(Icons.calendar_month)),
                          ],
                        )
                      ],
                    ),
                  ))),
          Card(
            elevation: 10,
            surfaceTintColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 253, 253, 253),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/paypal.png',
                        height: 50,
                        width: 50,
                      ),
                      Text(
                        ".... .... .... 3452",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Change",
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
