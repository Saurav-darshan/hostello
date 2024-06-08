import 'package:flutter/material.dart';
import 'package:hostello/Admin/Admin_landingScreen.dart';
import 'package:hostello/Colors/Colors.dart';

class Admin_LoginScreen extends StatefulWidget {
  const Admin_LoginScreen({super.key});

  @override
  State<Admin_LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Admin_LoginScreen> {
  bool isRemember = false;
  bool isObscure = true;
  bool isUserNotEmpty = false;
  bool isPasswordNotEmpty = false;
  int status = 0;
  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ccolor.p1,
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 3,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  color: Ccolor.p3,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(200),
                  )),
            ),
            Align(
                alignment: Alignment(0, -.7),
                child: Image.asset("assets/logo.png")),
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
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Form(
                        key: formKey,
                        child: Column(children: [
                          // Text(
                          //   "LOGIN",
                          //   style: TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 22,
                          //       fontWeight: FontWeight.w500),
                          // ),
                          // const SizedBox(height: 20),
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
                                  style: const TextStyle(color: Ccolor.p4),
                                ),
                              ]),
                              TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             ForgetPasswordScreen()));
                                },
                                child: Text(
                                  "Forgot password ?",
                                  style: const TextStyle(color: Ccolor.p4),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Admin_LandingScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              surfaceTintColor: Ccolor.p3,
                              shape: StadiumBorder(),
                              elevation: 20,
                              //shadowColor: myColor,
                              backgroundColor: Ccolor.p3,
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => SignupScreen(),
                              //     ));
                            },
                            child: Text(
                              "Don't have a account ? Signup",
                              style: const TextStyle(color: Ccolor.p4),
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
