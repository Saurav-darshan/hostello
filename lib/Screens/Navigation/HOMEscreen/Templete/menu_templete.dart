import 'package:flutter/material.dart';

class Menu_templete extends StatefulWidget {
  const Menu_templete({super.key});

  @override
  State<Menu_templete> createState() => _Menu_templeteState();
}

class _Menu_templeteState extends State<Menu_templete> {
  List<String> name = ["All", "House", "PG", "Hostel", "Beds", "Flats"];
  List<IconData> icon = [
    Icons.check,
    Icons.house,
    Icons.bed,
    Icons.home_work,
    Icons.family_restroom,
    Icons.waterfall_chart_sharp
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: name.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              width: 100,
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    icon[index],
                    color: Colors.green,
                  ),
                  Text(
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                      name[index])
                ],
              ));
        });
  }
}
