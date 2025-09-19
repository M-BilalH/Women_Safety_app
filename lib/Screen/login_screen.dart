import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wsfty_apk/Screen/register_Screen/register_as.dart';
import 'package:wsfty_apk/components/bottom_bar.dart';
import 'package:wsfty_apk/components/primarybutton.dart';
import 'package:wsfty_apk/components/textfield.dart';
import 'package:wsfty_apk/db/shared_pref.dart';
import 'package:wsfty_apk/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // const LoginScreen({super.key});
  bool isPasswordshow = false;
  final _formkey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isloading = false;
  _onSubmit() async {
    _formkey.currentState!.save();
    try {
      setState(() {
        isloading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _formData['email'].toString(),
            password: _formData['password'].toString(),
          );
      if (userCredential.user != null) {
        setState(() {
          isloading = false;
        });
        Fluttertoast.showToast(msg: "Succesfully Logged In");
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((value) {
              if (value['type'] == 'parent') {
                MySharedPrefferences.saveUsertype('parent');
                print(value['type']);
                goto(context, BottomPage(type: 'parent',));
              } else {
                MySharedPrefferences.saveUsertype('child');
                goto(context, BottomPage(type: 'child'));
              }
            });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "User not Found");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong Password or Username");
        print('Wrong password provided for that user.');
      } else {
        Fluttertoast.showToast(msg: "Wrong Credentials");
      }
      setState(() {
        isloading = false;
        goto(context, LoginScreen());
      });
    }
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              isloading
                  ? progressIndicator(context)
                  : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Column(
                              children: [
                                Text(
                                  'BINT-E-HAWWA',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Every Daughter Protected.',
                                  style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 35),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Form(
                            key: _formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    left: 30,
                                    right: 30,
                                    bottom: 10,
                                  ),
                                  child: CustomTextField(
                                    hintText: 'Username or Email',
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.emailAddress,
                                    prefix: Icon(Icons.person_2_outlined),
                                    onsave: (email) {
                                      _formData['email'] = email ?? "";
                                      
                                    },
                                    validate: (email) {
                                      if (email!.isEmpty ||
                                          email.length < 3 ||
                                          !email.contains("@")) {
                                        return 'Enter Valid Email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    left: 30,
                                    right: 30,
                                    bottom: 20,
                                  ),
                                  child: CustomTextField(
                                    hintText: 'Password',
                                    isPassword: isPasswordshow,
                                    prefix: Icon(Icons.lock_outline),
                                    onsave: (password) {
                                      _formData['password'] = password ?? "";
                                    },
                                    validate: (password) {
                                      if (password!.isEmpty ||
                                          password.length < 7) {
                                        return 'Password must be of 8 Letters';
                                      }
                                      return null;
                                    },
                                    suffix: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordshow = !isPasswordshow;
                                        });
                                      },
                                      icon:
                                          isPasswordshow
                                              ? Padding(
                                                padding: const EdgeInsets.all(
                                                  10.0,
                                                ),
                                                child: Icon(
                                                  Icons.visibility_off_outlined,
                                                ),
                                              )
                                              : Padding(
                                                padding: const EdgeInsets.all(
                                                  10.0,
                                                ),
                                                child: Icon(
                                                  Icons.visibility_outlined,
                                                ),
                                              ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    left: 30,
                                    right: 30,
                                  ),
                                  child: PrimaryButton(
                                    title: 'LOGIN',
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        _onSubmit();
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Dont have an account:',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      RegisterAs(),
                                    
                                    ],
                                    
                                  ),
                                ),
                                
                                
                              ],
                            ),
                          ),
                        ),
                        Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const Divider(), // The horizontal line
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Padding around the text
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200], // Background color to hide the divider behind the text
                                            ),
                                            child: const Text(
                                              'Or Sign In With', // Your desired text
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              Fluttertoast.showToast(msg: 'Coming Soon');
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.transparent,
                                              radius: 40,
                                              child: Image.asset('assets/googleicon.png'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Fluttertoast.showToast(msg: 'Coming Soon');
                                            },
                                            child: CircleAvatar(
                                              radius: 30,
                                              child: Image.asset('assets/facebookicon.png'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Fluttertoast.showToast(msg: 'Coming Soon');
                                            },
                                            child: CircleAvatar(
                                              radius: 30,
                                              child: Image.asset('assets/githubicon.png'),
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                    ),

                                  ],),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 45.0),
                                    child: InkWell(
                                      onTap:(){ Fluttertoast.showToast(msg: "New Version : App Crashes Fixed");},
                                      child: Text("App Version : 1.0.7",style: TextStyle(
                                                            fontWeight: FontWeight.w100,
                                                            color: Colors.grey[500]
                                                           ),),
                                    )
                                  )
                      ],
                      
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
