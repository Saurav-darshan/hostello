import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CallTabScreen extends StatefulWidget {
  const CallTabScreen({super.key});

  @override
  State<CallTabScreen> createState() => _CallTabScreenState();
}

class _CallTabScreenState extends State<CallTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return templete_call();
        },
      ),
    );
  }
}

class templete_call extends StatefulWidget {
  const templete_call({super.key});

  @override
  State<templete_call> createState() => _templete_callState();
}

class _templete_callState extends State<templete_call> {
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
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_outward_rounded,
                        color: Colors.green,
                      ),
                      Text(
                        " ${DateFormat('yMd').format(DateTime.now())}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: Icon(
              Icons.call,
              color: Colors.green[800],
              size: 25,
            ),
          )
          // Column(
          //   children: [
          //     Container(
          //       padding: EdgeInsets.all(5),
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.blue,
          //       ),
          //       child: Text(
          //         "3",
          //         style: TextStyle(
          //             color: Colors.white, fontWeight: FontWeight.w600),
          //       ),
          //     ),
          //     Text(
          //       "${DateFormat('yMd').format(DateTime.now())}",
          //       overflow: TextOverflow.fade,
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
