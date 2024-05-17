import 'package:flutter/material.dart';

class Profile_Edit extends StatefulWidget {
  const Profile_Edit({super.key});

  @override
  State<Profile_Edit> createState() => _Profile_EditState();
}

class _Profile_EditState extends State<Profile_Edit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          Stack(children: [
            Align(
                alignment: Alignment(0, -.7),
                child: CircleAvatar(
                  foregroundImage: AssetImage("assets/pp.jpg"),
                  radius: 60,
                )),
            Positioned(
              top: 88,
              left: 235,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              //color: Color.fromARGB(255, 222, 249, 255),
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        alignLabelWithHint: true,
                        hintText: 'Saurav Darshan',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        labelText: 'Fullname:',
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Color.fromARGB(151, 235, 233, 233),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                style: BorderStyle.solid))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        alignLabelWithHint: true,
                        hintText: 'Saurav',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        labelText: 'Username:',
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Color.fromARGB(151, 235, 233, 233),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                style: BorderStyle.solid))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        alignLabelWithHint: true,
                        hintText: '12/04/1909',
                        suffixIcon: Icon(
                          Icons.calendar_month,
                        ),
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        labelText: 'Date of Birth:',
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Color.fromARGB(151, 235, 233, 233),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                style: BorderStyle.solid))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        alignLabelWithHint: true,
                        hintText: 'MALE',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        labelText: 'Gender:',
                        suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Color.fromARGB(151, 235, 233, 233),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                style: BorderStyle.solid))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        alignLabelWithHint: true,
                        hintText: 'officialsauravdarshan@gmail.com',
                        suffixIcon: Icon(Icons.email),
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        labelText: 'Email Id:',
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Color.fromARGB(151, 235, 233, 233),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                style: BorderStyle.solid))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        alignLabelWithHint: true,
                        hintText: '+91 9162369093',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        labelText: 'Mobile :',
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Color.fromARGB(151, 235, 233, 233),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                style: BorderStyle.solid))),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 30,
                        right: 30,
                      ),
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
                          "Update",
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 243, 243),
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
