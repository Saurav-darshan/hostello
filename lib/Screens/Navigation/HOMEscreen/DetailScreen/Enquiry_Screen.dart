import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostello/Screens/LandingPage.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final String hostelname;
  final String address;
  final String rating;
  final String price;
  final String image;

  const BookingScreen({
    Key? key,
    required this.hostelname,
    required this.address,
    required this.rating,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String selected_date =
      DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _mobileNo = '';
  String _email = '';
  String _gender = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enquiry Summary"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height / 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                widget.image,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 15,
                                  ),
                                  Text(
                                    widget.rating,
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
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.hostelname,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            widget.address,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            "${widget.price} /mo",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Let's Connect",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Name', prefixIcon: Icon(Icons.person)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) => _name = value!,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Mobile No',
                            prefixIcon: Icon(Icons.phone)),
                        validator: (value) {
                          if (value!.isEmpty || value.length != 10) {
                            return 'Please enter a 10-digit mobile number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        onSaved: (value) => _mobileNo = value!,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Email', prefixIcon: Icon(Icons.email)),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) => _email = value!,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'Gender :',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Radio(
                            value: 'Male',
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          Text('Male'),
                          Radio(
                            value: 'Female',
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          Text('Female'),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _submitForm();
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext) {
                              return thanks_templete();
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          surfaceTintColor: Color.fromARGB(255, 0, 123, 255),
                          shape: StadiumBorder(),
                          elevation: 20,
                          backgroundColor: Color.fromARGB(255, 0, 149, 255),
                          minimumSize: const Size.fromHeight(60),
                        ),
                        child: const Text(
                          "Contact Us",
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 243, 243),
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      _saveEnquiryToFirestore();
      print('Name: $_name');
      print('Mobile No: $_mobileNo');
      print('Email: $_email');
      print('Gender: $_gender');
    }
  }

  Future<void> _saveEnquiryToFirestore() async {
    try {
      await _firestore.collection('enquiries').add({
        'name': _name,
        'mobileNo': _mobileNo,
        'email': _email,
        'gender': _gender,
        'hostelname': widget.hostelname,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending', // Set default status to pending
      });
    } catch (e) {
      print('Error saving enquiry: $e');
    }
  }
}

class thanks_templete extends StatelessWidget {
  const thanks_templete({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              "Thanks \n You.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 55,
                wordSpacing: 0,
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, top: 30),
            child: Text(
              "We'll be in touch\n Shortly !",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LandingPage(),
                          ));
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
