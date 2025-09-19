import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:wsfty_apk/utils/constants.dart';

class ArmyEmergency extends StatelessWidget {
  // const ArmyEmergency({super.key});
  _callNumber(String number) async{
  
   await FlutterPhoneDirectCaller.callNumber(number);
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,bottom: 5.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: ()=> _callNumber('1043'),
          child: Container(
            height: 180,
            width: MediaQuery.of(context).size.width*0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
               gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:[Color(0xff6A89A7),
              Color(0xff888DF2),
              Color(0xffBDDDFC),
               ])
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white.withOpacity(0.5),
                    child: Icon(
                      Icons.interpreter_mode_outlined,
                      color:Colors.white,
                      size: 35,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("PCSW",style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width*0.06,
                        ),),
                      ],
                    ),
                  ),
                  Text("For Harrassment or Violence",style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width*0.040,
                  ),),
                  Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                       color: Colors.white,
                     borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: Text('1-0-4-3',
                      style: TextStyle(
                      color:secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width*0.045,
                      ),
                                    ),
                    ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}