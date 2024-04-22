import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hostello/Screens/LandingPage.dart';
import 'package:hostello/Screens/Login/ForgetPasswordScreen.dart';
import 'package:hostello/Screens/Login/SignupScreen.dart';
import 'package:http/http.dart';
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
  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  void login(String username, String password) async {
    try {
      Response response = await post(
          Uri.parse("https://imapi.mybusi.net/api/auth/signin"),
          body: {
            "username": username,
            "password": password,
          });

      status = response.statusCode;
      if (response.statusCode == 200) {
        if (isRemember == true) {
          saveCredentials();
        }
        Map data = jsonDecode(response.body);
        String name = data["payload"]["name"];
        String image = data["payload"]["personnel"]["imageUrl"];
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("person_name", name.toString());
        sp.setString("image_uri", image.toString());
        sp.setString("role", data["payload"]["roles"].toString());
        sp.setString("accessToken", data["payload"]["accessToken"].toString());
        sp.setString(
            "personnel_id", data["payload"]["personnel"]["id"].toString());

        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(Welcome_Snack);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LandingPage(),
              ));
        });
      } else if (response.statusCode == 401) {
        print(
            "RESPONSE:_______${response.statusCode}__________________ ${response.body.toString()}");
      } else {
        print(
            "RESPONSE:_______${response.statusCode}__________________ ${response.body}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

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
                            "Welcome Back !",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              value = status.toString();
                              if (value == "404") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(User_Snack);
                                return "User Not Found";
                              } else {
                                return null;
                              }
                            },
                            controller: UsernameController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_3),
                                hintText: 'Username'),
                          ),
                          const SizedBox(height: 40),
                          TextFormField(
                            validator: (value) {
                              value = status.toString();
                              if (value == "401") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(Password_Snack);

                                return "Invalid Password";
                              } else {
                                return null;
                              }
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
                                      login(UsernameController.text.toString(),
                                          PasswordController.text.toString());
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
                            child: const Text(
                              "LOGIN",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 243, 243, 243),
                                  fontSize: 20),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ));
                            },
                            child: Text(
                              "Don't have a account ? Signup",
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

  final User_Snack = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
        ),
        height: 30,
        child: Text(
          "User Not Found !",
          style: TextStyle(),
        ),
      ));
  final Password_Snack = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
        ),
        height: 30,
        child: Text(
          "Invalid Password !",
          style: TextStyle(),
        ),
      ));
}
