import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Color primaryColor = Color(0xff888DF2);
Color secondaryColor =Color(0xff6A89A7);
Color tercaryColor =   Color(0xff384959);
Color hoverColor =   Color(0xffBDDDFC);

void goto(BuildContext context, Widget nextScreen) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => nextScreen));
}
 Widget progressIndicator(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
          color: primaryColor,
          strokeWidth: 7,
        ),
      ),
    );

}
dialogbox(BuildContext context,String text){
showDialog(context: context, builder: (context)=> AlertDialog(
  title: Text(text),
));
}
