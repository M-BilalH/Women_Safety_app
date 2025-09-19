import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wsfty_apk/Screen/intro_screen.dart';
import 'package:wsfty_apk/Screen/login_screen.dart';
import 'package:wsfty_apk/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   _getPermission() async => await [Permission.sms,Permission.locationWhenInUse].request();
  @override
  void initState() {
    super.initState();
    _getPermission();
    Timer(Duration(seconds: 9), () {
      goto(context, INTROScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff6A89A7), Color(0xff888DF2), Color(0xffBDDDFC)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(width: 20.0, height: 100.0),
          const Text(
            'Be',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 43.0, color: Colors.deepPurpleAccent),
          ),
          const SizedBox(width: 20.0, height: 100.0),
          SizedBox(
            width: 200,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 40.0,
                // fontFamily:
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  RotateAnimatedText(
                    'Aware',
                    alignment: Alignment.centerLeft,
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    duration: Duration(seconds: 2),
                  ),
                  RotateAnimatedText(
                    'Confident',
                    alignment: Alignment.centerLeft,
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    duration: Duration(seconds: 2),
                  ),
                  RotateAnimatedText(
                    'Protected',
                    alignment: Alignment.centerLeft,
                    textStyle: TextStyle(fontWeight: FontWeight.bold,),
                    duration: Duration(seconds: 4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // Scaffold(
    //   body: Container(
    //     width: double.infinity,
    //     decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //             begin: Alignment.topLeft,
    //             end: Alignment.bottomRight,
    //             colors:[Color(0xff6A89A7),
    //           Color(0xff888DF2),
    //           Color(0xffBDDDFC),
    //            ])
    //     ),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(top: 250,right: 10),
    //           child: Center(child: Image(image: AssetImage('assets/logoimage.png'))),
    //         ),

    //         Padding(
    //           padding: const EdgeInsets.only(top: 250),
    //           child: Text("Bint-e-Hawwa",style: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold,
    //             color: secondaryColor,
    //           ),),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
