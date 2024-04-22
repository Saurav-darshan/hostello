import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String _email = '';
  bool isObscure = true;
  String _otp = '';
  String _newPassword = '';
  final _passwordPattern =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,16}$');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      print('Email: $_email');
      print('OTP: $_otp');
      print('New Password: $_newPassword');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/bg3.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned(
                  top: 80,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/logo.png",
                          scale: 1.4,
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
                        padding: EdgeInsets.all(32.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Forget Password ?",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Email ID',
                                    prefixIcon: Icon(Icons.email)),
                                onChanged: (value) {
                                  setState(() {
                                    _email = value;
                                  });
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 1,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Send OTP",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 3, 87, 183)),
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'OTP',
                                    prefixIcon: Icon(Icons.pin)),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _otp = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter OTP';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'New Password',
                                  prefixIcon: Icon(Icons.lock),
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
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _newPassword = value;
                                  });
                                },
                                obscureText: true,
                                validator: (value) {
                                  if (!_passwordPattern.hasMatch(value ?? '')) {
                                    return 'Password must contain at least one uppercase letter, one lowercase letter, one digit, one special character, and be 8-16 characters long.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 50),
                              ElevatedButton(
                                onPressed: () {
                                  _resetPassword();
                                },
                                style: ElevatedButton.styleFrom(
                                  surfaceTintColor:
                                      Color.fromARGB(255, 0, 123, 255),
                                  shape: StadiumBorder(),
                                  elevation: 20,
                                  //shadowColor: myColor,
                                  backgroundColor:
                                      Color.fromARGB(255, 0, 149, 255),
                                  minimumSize: const Size.fromHeight(60),
                                ),
                                child: const Text(
                                  "Reset Password",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 243, 243, 243),
                                      fontSize: 20),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Reset password via SMS",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 4, 112, 167)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
