import 'package:flutter/material.dart';
import 'package:wsfty_apk/Screen/register_Screen/register_child.dart';
import 'package:wsfty_apk/Screen/register_Screen/register_parent.dart';
import 'package:wsfty_apk/utils/constants.dart';

class RegisterAs extends StatefulWidget {
  const RegisterAs({super.key});

  @override
  State<RegisterAs> createState() => _RegisterAsState();
}

class _RegisterAsState extends State<RegisterAs> {
  showModel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  width: 120,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[400],
                  ),
                ),
              ),
Padding(
  padding: const EdgeInsets.all(15.0),
  child: Center(child: Text("Register As:",style: TextStyle(
    fontSize: 20,
  fontWeight: FontWeight.bold
  ),)),
),
     Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
                    height: 60,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: (){
                         goto(context, RegisterChildScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff888DF2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        
                      ),
                      child: Text(
                        'Children',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
               
        Container(
                    height: 60,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: (){
                         goto(context, RegisterParentScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff888DF2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        
                      ),
                      child: Text(
                        'Parent',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
               
             
      ],
     ),         
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
     return InkWell(
      onTap: () => showModel(context),
      child: Text("  SignUp",style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: primaryColor
      ),),
      
    );
  }
}