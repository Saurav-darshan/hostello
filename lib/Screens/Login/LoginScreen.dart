import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hostello/Admin/Admin_Splash.dart';
import 'package:hostello/Screens/LandingPage.dart';
import 'package:hostello/Screens/Login/ForgetPasswordScreen.dart';
import 'package:hostello/Screens/Login/SignupScreen.dart';
import 'package:hostello/auth/User_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color myColor = Color.fromARGB(255, 246, 198, 127);
  bool isRemember = false;
  bool isObscure = true;
  bool isUserNotEmpty = false;
  bool isPasswordNotEmpty = false;
  int status = 0;
  bool _isSigning = false;
  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  //-----------firebase - connection-----
  final firebaseAuthService _auth = firebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // void login(String username, String password) async {
  //   try {
  //     Response response = await post(
  //         Uri.parse("https://imapi.mybusi.net/api/auth/signin"),
  //         body: {
  //           "username": username,
  //           "password": password,
  //         });

  //     status = response.statusCode;
  //     if (response.statusCode == 200) {
  //       if (isRemember == true) {
  //         saveCredentials();
  //       }
  //       Map data = jsonDecode(response.body);
  //       String name = data["payload"]["name"];
  //       String image = data["payload"]["personnel"]["imageUrl"];
  //       SharedPreferences sp = await SharedPreferences.getInstance();
  //       sp.setString("person_name", name.toString());
  //       sp.setString("image_uri", image.toString());
  //       sp.setString("role", data["payload"]["roles"].toString());
  //       sp.setString("accessToken", data["payload"]["accessToken"].toString());
  //       sp.setString(
  //           "personnel_id", data["payload"]["personnel"]["id"].toString());

  //       setState(() {
  //         ScaffoldMessenger.of(context).showSnackBar(Welcome_Snack);
  //         Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => LandingPage(),
  //             ));
  //       });
  //     } else if (response.statusCode == 401) {
  //       print(
  //           "RESPONSE:_______${response.statusCode}__________________ ${response.body.toString()}");
  //     } else {
  //       print(
  //           "RESPONSE:_______${response.statusCode}__________________ ${response.body}");
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  void initState() {
    UsernameController.addListener(() {
      final isUserNotEmpty = UsernameController.text.isNotEmpty;

      setState(() {
        this.isUserNotEmpty = isUserNotEmpty;
      });
    });

    PasswordController.addListener(() {
      final isPasswordNotEmpty = PasswordController.text.isNotEmpty;
      setState(() {
        this.isPasswordNotEmpty = isPasswordNotEmpty;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    UsernameController.dispose();
    PasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: myColor,
          image: DecorationImage(
            image: const AssetImage("assets/bg2.png"),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
                top: 70,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        scale: 1,
                        filterQuality: FilterQuality.high,
                      )
                    ],
                  ),
                )),
            Positioned(
              bottom: 0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    //color: Color.fromARGB(255, 148, 203, 241),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Form(
                        key: formKey,
                        child: Column(children: [
                          Text(
                            "Welcome User !",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              value = status.toString();
                            },
                            controller: UsernameController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_3),
                                hintText: 'Email'),
                          ),
                          const SizedBox(height: 40),
                          TextFormField(
                            validator: (value) {
                              value = status.toString();
                            },
                            obscureText: isObscure,
                            controller: PasswordController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password_rounded),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    if (isObscure == true) {
                                      setState(() {
                                        isObscure = false;
                                      });
                                    } else {
                                      setState(() {
                                        isObscure = true;
                                      });
                                    }
                                  },
                                  child: isObscure == false
                                      ? Icon(Icons.visibility_off_rounded)
                                      : Icon(Icons.visibility_rounded),
                                ),
                                hintText: 'Password'),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Checkbox(
                                    value: isRemember,
                                    onChanged: (value) {
                                      setState(() {
                                        isRemember = value!;
                                      });
                                    }),
                                Text(
                                  "Remember Me",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ]),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgetPasswordScreen()));
                                },
                                child: Text(
                                  "Forgot password ?",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 3, 87, 183)),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: (isUserNotEmpty == true &&
                                    isPasswordNotEmpty == true)
                                ? () {
                                    if (formKey.currentState!.validate()) {
                                      // login(UsernameController.text.toString(),
                                      //     PasswordController.text.toString());
                                      Firebase_signin();
                                    } else {
                                      UsernameController.clear();
                                      PasswordController.clear();
                                      status = 0;
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              surfaceTintColor:
                                  Color.fromARGB(255, 0, 123, 255),
                              shape: StadiumBorder(),
                              elevation: 20,
                              //shadowColor: myColor,
                              backgroundColor: Color.fromARGB(255, 0, 149, 255),
                              minimumSize: const Size.fromHeight(60),
                            ),
                            child: _isSigning
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 243, 243, 243),
                                        fontSize: 20),
                                  ),
                          ),
                          TextButton(
                            onPressed: () {
                              // _signInWithGoogle();
                              showModalBottomSheet(
                                  isScrollControlled: false,
                                  context: context,
                                  builder: (Buildercontext) {
                                    return otherloginOption();
                                  });
                            },
                            child: Text(
                              "Try another option",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 4, 112, 167)),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

//------firebase signin-----------------\\
  // void Firebase_signin() async {
  //   setState(() {
  //     _isSigning = true;
  //   });

  //   String email = UsernameController.text;
  //   String password = PasswordController.text;
  //   User? user = await _auth.signinwithemailandpassword(email, password);

  //   if (user != null) {
  //     print("login");
  //     if (isRemember == true) {
  //       saveCredentials();
  //     }
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => LandingPage()));
  //     ScaffoldMessenger.of(context).showSnackBar(Welcome_Snack);
  //   } else {
  //     print(" error --------->>>>>>>");
  //     UsernameController.clear();
  //     PasswordController.clear();
  //   }
  //   setState(() {
  //     _isSigning = false;
  //   });
  // }
  void Firebase_signin() async {
    setState(() {
      _isSigning = true;
    });

    String email = UsernameController.text;
    String password = PasswordController.text;
    User? user = await _auth.signinwithemailandpassword(email, password);

    if (user != null) {
      if (user.emailVerified) {
        // Proceed with login if email is verified
        if (isRemember == true) {
          saveCredentials();
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
        ScaffoldMessenger.of(context).showSnackBar(Welcome_Snack);
      } else {
        // Email not verified, handle accordingly (e.g., show a message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please verify your email before logging in."),
          ),
        );
      }
    } else {
      // Handle sign-in failure (invalid credentials, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid credentials. Please try again."),
        ),
      );
      UsernameController.clear();
      PasswordController.clear();
    }

    setState(() {
      _isSigning = false;
    });
  }

//---------------google auth signin function-----------------------------\\

  // _signInWithGoogle() async {
  //   final firebaseAuthService _auth = firebaseAuthService();
  //   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //   final GoogleSignIn _googleSignIn = GoogleSignIn();

  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();

  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;

  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         idToken: googleSignInAuthentication.idToken,
  //         accessToken: googleSignInAuthentication.accessToken,
  //       );

  //       await _firebaseAuth.signInWithCredential(credential);
  //       Navigator.pushNamed(context, "/home");
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: '"some error occured $e"');
  //     log("${e}");
  //   }
  //}

//------firebase signin-----------------\\

  void saveCredentials() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("isLogin", UsernameController.toString());
  }

  final Welcome_Snack = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.green[700],
        ),
        height: 30,
        child: Text(
          "Login Successfull !",
          style: TextStyle(),
        ),
      ));
}

//----------------------------------- other options list  templete-----------------------\\
class otherloginOption extends StatelessWidget {
  const otherloginOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _signInWithGoogle();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.grey),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/google.png',
                      height: 30.0,
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.grey),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                  ));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image.asset(
                //   'assets/google.png',
                //   height: 30.0,
                // ),
                Text(
                  "Don't have a account ? Signup",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                minimumSize: MaterialStatePropertyAll(Size(80, 40)),
                shape: MaterialStatePropertyAll(
                    StadiumBorder(side: BorderSide(color: Colors.black)))),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Admin_SplashScreen(),
                  ));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.admin_panel_settings),
                Text(
                  "Admin Login",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _signInWithGoogle() async {
    final firebaseAuthService _auth = firebaseAuthService();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '"some error occured $e"');
    }
  }
}
