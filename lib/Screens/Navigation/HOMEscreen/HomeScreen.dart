import 'package:flutter/material.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/NotificationScreen.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/OurRecommendation.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/Templete/Featured_templete.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/Templete/Grid_templete.dart';
import 'package:hostello/Screens/Navigation/HOMEscreen/Templete/menu_templete.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          leading: Padding(
            padding: EdgeInsets.only(left: 10),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              foregroundImage: AssetImage("assets/pp.jpg"),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                        ));
                  },
                  icon: Icon(Icons.notifications),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(158, 232, 233, 232)))),
            )
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning 👋",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Saurav Darshan",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              Container(
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(40, 158, 158, 158),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [Icon(Icons.search), Text('Search')],
                    ),
                    InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: false,
                              context: context,
                              builder: (Buildercontext) {
                                return FilterPannel();
                              });
                        },
                        child: Icon(Icons.format_list_bulleted_sharp))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Featured",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.2,
                child: FeaturedTemplate(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Our Recommendation",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OurRecommendation(),
                            ));
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
              SizedBox(height: 50, child: Menu_templete()),
              SizedBox(height: 650, child: Grid_templete()),
            ]),
          ),
        ),
      ),
    );
  }
}

class FilterPannel extends StatefulWidget {
  const FilterPannel({super.key});

  @override
  State<FilterPannel> createState() => _FilterPannelState();
}

class _FilterPannelState extends State<FilterPannel> {
  RangeValues values = const RangeValues(1000, 20000);
  List<DropdownMenuEntry<String>> address = [
    DropdownMenuEntry(
        value: "Rajendra Nagar, Patna", label: "Rajendra Nagar, Patna"),
    DropdownMenuEntry(value: "Frazer Road, Patna", label: "Frazer Road, Patna"),
    DropdownMenuEntry(
        value: "Phulwari Sharif, Patna", label: "Phulwari Sharif, Patna"),
    DropdownMenuEntry(value: "Bailey Road, Patna", label: "Bailey Road, Patna"),
  ];
  String DropdownValue = "Select Location";
  @override
  Widget build(BuildContext context) {
    RangeLabels labels =
        RangeLabels(values.start.toString(), values.end.toString());
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Category",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.sizeOf(context).width,
              child: Menu_templete(),
            ),
            Text(
              "Price Range",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: RangeSlider(
                  max: 20000,
                  min: 1000,
                  divisions: 10,
                  labels: labels,
                  values: values,
                  onChanged: (newValues) {
                    setState(() {
                      values = newValues;
                    });
                  }),
            ),
            Text(
              "Facilities",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.sizeOf(context).width,
              child: Menu_templete(),
            ),
            Text(
              "Locations",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            DropdownMenu(
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              hintText: "select Location",
              width: MediaQuery.sizeOf(context).width - 40,
              enableSearch: true,
              dropdownMenuEntries: address,
              enableFilter: true,
            ),
            Text(
              "Rating",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.sizeOf(context).width,
              child: Menu_templete(),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    surfaceTintColor: Color.fromARGB(255, 0, 123, 255),
                    shape: StadiumBorder(),
                    elevation: 20,
                    //shadowColor: myColor,
                    backgroundColor: Color.fromARGB(255, 251, 253, 255),
                  ),
                  child: const Text(
                    "Reset",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 123, 255), fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    surfaceTintColor: Color.fromARGB(255, 0, 123, 255),
                    shape: StadiumBorder(),
                    elevation: 20,
                    //shadowColor: myColor,
                    backgroundColor: Color.fromARGB(255, 0, 149, 255),
                  ),
                  child: const Text(
                    "Apply",
                    style: TextStyle(
                        color: Color.fromARGB(255, 243, 243, 243),
                        fontSize: 20),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
