import 'package:flutter/material.dart';
import 'package:hostello/Screens/Login/LoginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _mobileNo = '';
  String _email = '';
  String _password = '';
  String _gender = '';
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage("assets/bg7.png"),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Positioned(
                top: 10,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        scale: 1.8,
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
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Sign up Now!",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Name',
                                    prefixIcon: Icon(Icons.person)),
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
                                    hintText: 'Email',
                                    prefixIcon: Icon(Icons.email)),
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
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Password',
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
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      value.length < 8 ||
                                      value.length > 16 ||
                                      !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,16}$')
                                          .hasMatch(value)) {
                                    return 'Password must be 8-16 characters long \n contain at least one uppercase letter\n, one lowercase letter, one number,\n and one special character';
                                  }
                                  return null;
                                },
                                obscureText: isObscure,
                                onSaved: (value) => _password = value!,
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    'Gender :',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                  // Radio(

                                  //   value: 'Others',
                                  //   groupValue: _gender,
                                  //   onChanged: (value) {
                                  //     setState(() {
                                  //       _gender = value!;
                                  //     });
                                  //   },
                                  // ),
                                  // Text(
                                  //   'Others',
                                  // ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  _submitForm();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(Signup_snack);
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
                                  "Sign Up",
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
                                        builder: (context) => LoginScreen(),
                                      ));
                                },
                                child: Text(
                                  "Already have a account ? Login",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 4, 112, 167)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                )),
          ]),
        ));
  }

  void _submitForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      // Process signup with the entered data
      print('Name: $_name');
      print('Mobile No: $_mobileNo');
      print('Email: $_email');
      print('Password: $_password');

      print('Gender: $_gender');
    }
  }

  final Signup_snack = SnackBar(
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
          "Sign Up Successfull !",
          style: TextStyle(),
        ),
      ));
}
