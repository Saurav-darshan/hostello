import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payments",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w800),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.qr_code_scanner)),
        ],
      ),
      body: Container(
        //color: Colors.amber,
        // child: Center(
        //   child: IconButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       icon: Icon(Icons.arrow_back_ios_new_rounded)),
        // ),

        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 222, 221, 216),
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
                        "Paypal",
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
                        "Connected",
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
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 222, 221, 216),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/google.png',
                        height: 50,
                        width: 50,
                      ),
                      Text(
                        "Google Pay",
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
                        "Connected",
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
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 222, 221, 216),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/apple.png',
                        height: 50,
                        width: 50,
                      ),
                      Text(
                        "Apple Pay",
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
                        "Connected",
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
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 222, 221, 216),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/master.png',
                        height: 50,
                        width: 50,
                      ),
                      Text(
                        ".... .... .... 9899",
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
                        "Connected",
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
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 60),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Color.fromARGB(255, 0, 123, 255),
                  shape: StadiumBorder(),
                  elevation: 20,
                  //shadowColor: myColor,
                  backgroundColor: Color.fromARGB(255, 0, 149, 255),
                  minimumSize: const Size.fromHeight(60),
                ),
                child: const Text(
                  "Add New Card",
                  style: TextStyle(
                      color: Color.fromARGB(255, 243, 243, 243), fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
