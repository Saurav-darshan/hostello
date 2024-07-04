import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostello/Modals/User_Auth_modal.dart';
import 'package:hostello/Screens/Login/LoginScreen.dart';
import 'package:hostello/auth/User_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSigningUP = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final firebaseAuthService _auth = firebaseAuthService();
  String _gender = '';
  String _role = 'user'; // Default role is user
  bool isObscure = true;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileNoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/bg7.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
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
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
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
                            "Sign up Now!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _mobileNoController,
                            decoration: InputDecoration(
                              hintText: 'Mobile No',
                              prefixIcon: Icon(Icons.phone),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length != 10) {
                                return 'Please enter a 10-digit mobile number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                child: Icon(
                                  isObscure
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                ),
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
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                'Gender:',
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
                          Row(
                            children: [
                              Text(
                                'Sign up as:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Radio(
                                value: 'user',
                                groupValue: _role,
                                onChanged: (value) {
                                  setState(() {
                                    _role = value!;
                                  });
                                },
                              ),
                              Text('User'),
                              Radio(
                                value: 'admin',
                                groupValue: _role,
                                onChanged: (value) {
                                  setState(() {
                                    _role = value!;
                                  });
                                },
                              ),
                              Text('Admin'),
                            ],
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _submitForm();
                            },
                            style: ElevatedButton.styleFrom(
                              surfaceTintColor:
                                  Color.fromARGB(255, 0, 123, 255),
                              shape: const StadiumBorder(),
                              elevation: 20,
                              backgroundColor: Color.fromARGB(255, 0, 149, 255),
                              minimumSize: const Size.fromHeight(60),
                            ),
                            child: _isSigningUP
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 243, 243, 243),
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
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
                              "Already have a account? Login",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 4, 112, 167),
                              ),
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

  void firebase_signup() async {
    setState(() {
      _isSigningUP = true;
    });
    String username = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String mobile = _mobileNoController.text;
    String gender = _gender;
    String role = _role;
    User? user = await _auth.signupwithemailandpassword(email, password);

    if (user != null) {
      _createData(UserModel(
        username: username,
        email: email,
        mobile: mobile,
        gender: gender,
        role: role,
      ));
      print("user created");
      ScaffoldMessenger.of(context).showSnackBar(Signup_snack);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
      setState(() {
        _isSigningUP = false;
      });
    } else {
      print(" error --------->>>>>>>");
      setState(() {
        _isSigningUP = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(erroe_snack);

      _emailController.clear();
    }
  }

  //------------------------------------------------------------------------\\
  //---------->>>>> .  add data to firebase  <<<----------------------\\
  void _createData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    String? uid = FirebaseAuth.instance.currentUser?.uid ?? userModel.id;

    final newUser = UserModel(
      username: userModel.username,
      email: userModel.email,
      mobile: userModel.mobile,
      gender: userModel.gender,
      role: userModel.role,
      id: uid,
    ).toJson();

    userCollection.doc(uid).set(newUser);
  }

  //---------->>>>> .  update data of firebase  <<<----------------------\\
  void _updateData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("users");
    final newUser = UserModel(
            username: userModel.username,
            email: userModel.email,
            mobile: userModel.mobile,
            gender: userModel.gender,
            role: userModel.role,
            id: userModel.id)
        .toJson();

    userCollection.doc(userModel.id).update(newUser);
  }
  //---------->>>>> .  read data of firebase  <<<----------------------\\

  void _submitForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      // Process signup with the entered data
      firebase_signup();

      print('Name: ${_nameController.text}');
      print('Mobile No: ${_mobileNoController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('Gender: $_gender');
      print('Role: $_role');
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
            "Sign Up Successful!",
            style: TextStyle(),
          )));

  final erroe_snack = SnackBar(
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
            "Email Already used",
            style: TextStyle(),
          )));
}
