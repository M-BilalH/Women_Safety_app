import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  // const PrimaryButton({super.key});
final String title;
final Function onPressed;
bool loading;
PrimaryButton({required this.title,required this.onPressed,this.loading=false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(onPressed: (){
        onPressed();
      }, child: Text(title,style: TextStyle(
        fontSize: 18,
        color: Colors.white
      ),),
      style: ElevatedButton.styleFrom(
        backgroundColor:  Color(0xff888DF2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        )
      ),
      ),
    );
  }
}