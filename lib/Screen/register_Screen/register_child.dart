import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wsfty_apk/Screen/login_screen.dart';
import 'package:wsfty_apk/components/primarybutton.dart';
import 'package:wsfty_apk/components/secondarybutton.dart';
import 'package:wsfty_apk/components/textfield.dart';
import 'package:wsfty_apk/model/user_model.dart';
import 'package:wsfty_apk/utils/constants.dart';

class RegisterChildScreen extends StatefulWidget {
  @override
  State<RegisterChildScreen> createState() => _RegisterChildScreenState();
}

class _RegisterChildScreenState extends State<RegisterChildScreen> {
  // const RegisterChildScreen({super.key});
  bool isPasswordshow = false;
  bool isrPasswordshow = false;

  final _formkey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();
  bool isloading= false;

  _onSubmit() async{
    _formkey.currentState!.save();
    if (_formData['password'] != _formData['rpassword']) {
      dialogbox(context, 'PASSWORD DOESNT MATCH');
    } else {
      progressIndicator(context);
      try {
        setState(() {
        isloading=true;
      });
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
   email: _formData['email'].toString(),
              password: _formData['password'].toString(),
  );
  if(userCredential.user !=null){
    setState(() {
        isloading=true;
      });
    final v = userCredential.user!.uid;
  DocumentReference<Map<String, dynamic>> db= FirebaseFirestore.instance.collection('users').doc(v);
              final user= UserModel(
                name: _formData['name'].toString(),
                phone: _formData['phone'].toString(),
                childEmail:  _formData['email'].toString(),
                parentEmail:  _formData['gemail'].toString(),
                id: v,
                type: 'child',
              );
              final jsonData =user.toJson();
              await db.set(jsonData).whenComplete((){
goto(context, LoginScreen());
setState(() {
        isloading=false;
      });
              });
  }
} on FirebaseAuthException catch (e) {
  setState(() {
        isloading=false;
      });
  if (e.code == 'weak-password') {
    dialogbox(context, 'The password provided is too weak');
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    dialogbox(context, 'The account already exists for that email.');
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
  setState(() {
        isloading=false;
      });
  dialogbox(context, e.toString());
}
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.white,
        elevation: 09,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Text(
              "Register/Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          isloading?progressIndicator(context):
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(                               
                                    left: 30,
                                    right: 30,                                  
                                  ),
              child: Column(
                children: [
                                       Padding(
                                         padding: const EdgeInsets.only(top: 30),
                                         child: Container(
                                                                   width: MediaQuery.of(context).size.width,
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20,bottom: 10),
                            child: CustomTextField(
                              hintText: 'Username',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.name,
                              prefix: Icon(Icons.person),
                              onsave: (name) {
                                _formData['name'] = name ?? "";
                              },
                              validate: (email) {
                                if (email!.isEmpty || email.length < 3) {
                                  return 'Enter Valid Username';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            child: CustomTextField(
                              hintText: 'Enter Email',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.emailAddress,
                              prefix: Icon(Icons.email),
                              onsave: (email) {
                                _formData['email'] = email ?? "";
                              },
                              validate: (email) {
                                if (email!.isEmpty ||
                                    email.length < 3 ||
                                    !email.contains("@gmail.com")) {
                                  return 'Enter Valid Email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            child: CustomTextField(
                              hintText: 'Enter Phone Number',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.phone,
                              prefix: Icon(Icons.phone),
                              onsave: (phone) {
                                _formData['phone'] = phone ?? "";
                              },
                              validate: (email) {
                                if (email!.isEmpty || email.length < 11) {
                                  return 'Enter Valid Phone Number';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            child: CustomTextField(
                              hintText: 'Enter Guardian Email',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.emailAddress,
                              prefix: Icon(Icons.email),
                              onsave: (gemail) {
                                _formData['gemail'] = gemail ?? "";
                              },
                              validate: (email) {
                                if (email!.isEmpty ||
                                    email.length < 5 ||
                                    !email.contains("@gmail.com")) {
                                  return 'Enter Valid Email';
                                }
                                return null;
                              },
                            ),
                          ),          
                          Padding(
                           padding: const EdgeInsets.only(top: 10,bottom: 10),
                            child: CustomTextField(
                              hintText: 'Password',
                              isPassword: isPasswordshow,
                              prefix: Icon(Icons.vpn_key_sharp),
                              onsave: (password) {
                                _formData['password'] = password ?? "";
                              },
                              validate: (password) {
                                if (password!.isEmpty || password.length < 7) {
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
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                              ),
                            ),
                          ),
                          Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                            child: CustomTextField(
                              hintText: 'Confirm Password',
                              isPassword: isrPasswordshow,
                              prefix: Icon(Icons.vpn_key_sharp),
                              onsave: (password) {
                                _formData['rpassword'] = password ?? "";
                              },
                              validate: (rpassword) {
                                if (rpassword!.isEmpty || rpassword.length < 7) {
                                  return 'Password must be of 8 Letters';
                                }
                                return null;
                              },
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isrPasswordshow = !isrPasswordshow;
                                  });
                                },
                                icon:
                                    isrPasswordshow
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                              ),
                            ),
                          ),
                          Padding(
                           padding: const EdgeInsets.only(top: 10,bottom: 10),
                            child: PrimaryButton(
                              title: 'Register Now',
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  _onSubmit();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account:',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SecondaryButton(
                              title: 'Log In',
                              onPressed: () {
                                goto(context, LoginScreen());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
