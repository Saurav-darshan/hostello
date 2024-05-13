import 'package:flutter/material.dart';
import 'package:hostello/Screens/LandingPage.dart';
import 'package:hostello/Screens/Navigation/CallTabScreen.dart';
import 'package:intl/intl.dart';

class Message_Screen extends StatefulWidget {
  const Message_Screen({super.key});

  @override
  State<Message_Screen> createState() => _Message_ScreenState();
}

class _Message_ScreenState extends State<Message_Screen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                scrolledUnderElevation: 0,
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [Text("Chats"), Text("Calls")],
                ),
                leading: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LandingPage(),
                            ));
                      },
                      icon: Icon(
                        Icons.home,
                        color: Colors.blue,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 255, 255, 255)))),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.search),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.more_horiz),
                  ),
                ],
                title: Text(
                  "Message",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                centerTitle: false,
              ),
              body: TabBarView(children: [
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return MessageTemplete();
                  },
                ),
                CallTabScreen()
              ])
              // MessageTemplete()
              // ToggleButtons(isSelected: [false], children: [Text("data")])
              ),
        ));
  }
}

class MessageTemplete extends StatefulWidget {
  const MessageTemplete({super.key});

  @override
  State<MessageTemplete> createState() => _MessageTempleteState();
}

class _MessageTempleteState extends State<MessageTemplete> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  foregroundImage: AssetImage("assets/pp.jpg"),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Saurav Darshan",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "Good Morning 👋",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Text(
                  "3",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "${DateFormat('yMd').format(DateTime.now())}",
                overflow: TextOverflow.fade,
              )
            ],
          )
        ],
      ),
    );
  }
}
