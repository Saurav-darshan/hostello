import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostello/Admin/Admin_ForgetPassword.dart';
import 'package:hostello/Admin/Admin_landingScreen.dart';
import 'package:hostello/Colors/Colors.dart';
import 'package:hostello/Screens/Login/LoginScreen.dart';

class Admin_LoginScreen extends StatefulWidget {
  const Admin_LoginScreen({Key? key}) : super(key: key);

  @override
  State<Admin_LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Admin_LoginScreen> {
  bool isObscure = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ccolor.p1,
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Ccolor.p3,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                  bottomRight: Radius.circular(200),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.7),
              child: Image.asset("assets/logo.png"),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Ccolor.p1,
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
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Username',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                              ),
                              hintText: 'Password',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Admin_ForgetPassword(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(color: Ccolor.p4),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                _login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Ccolor.p3,
                              shape: StadiumBorder(),
                              elevation: 20,
                              minimumSize: Size.fromHeight(60),
                            ),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'User Login? Click Here!',
                              style: TextStyle(color: Ccolor.p4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Check user's role
      _checkUserRole(userCredential.user!.uid);
    } catch (e) {
      // Handle login errors
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-email') {
          usernameController.clear();
          passwordController.clear();
          Fluttertoast.showToast(
            msg: 'User not found',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        } else if (e.code == 'invalid-credential') {
          passwordController..clear();
          Fluttertoast.showToast(
            msg: 'Invalid password',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        } else {
          print('Firebase login error: $e');
          Fluttertoast.showToast(
            msg: "Error: ${e}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
          );
        }
      }
    }
  }

  void _checkUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        String role = userDoc.get('role');
        if (role == 'admin') {
          // Navigate to admin landing screen on successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Admin_LandingScreen()),
          );
        } else {
          passwordController.clear();
          usernameController.clear();
          Fluttertoast.showToast(
            msg: 'Access Denied: Admins Only',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } else {
        passwordController.clear();
        usernameController.clear();
        Fluttertoast.showToast(
          msg: 'User role not found',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print('Error checking user role: $e');
      Fluttertoast.showToast(
        msg: 'Error checking user role',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
