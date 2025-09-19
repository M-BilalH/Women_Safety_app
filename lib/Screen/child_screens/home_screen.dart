import 'dart:math';
import 'package:wsfty_apk/db/db_services.dart';
import 'package:wsfty_apk/model/contact_model.dart';
import 'package:wsfty_apk/utils/constants.dart';
import 'package:wsfty_apk/widgets/home%20widget/custom_appBar.dart';
import 'package:wsfty_apk/widgets/home%20widget/custom_carousel.dart';
import 'package:wsfty_apk/widgets/home%20widget/emergency.dart';
import 'package:wsfty_apk/widgets/home%20widget/livesafe.dart';
import 'package:wsfty_apk/widgets/home%20widget/safehome/Safehome.dart';
import 'package:another_telephony/telephony.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen  extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen ({super.key});
int qIndex = 2;
  Position? _currentPosition;
 String? _currentAddress;
  LocationPermission? permission;
  Telephony? telephony = Telephony.instance;
  _getPermission() async => await [Permission.sms,Permission.locationWhenInUse].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message,) async {
    try{
    await telephony!.sendSms(
       to: phoneNumber,
      message: message,
      
    );
   Fluttertoast.showToast(msg: "Message Sent Successfully");
} catch (e) {
  Fluttertoast.showToast(msg: "Failed to send: ${e.toString()}");
}
  }
_getCurrentLocation()async{

  permission= await Geolocator.checkPermission();
  
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(msg: "Location Permission is denied");
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Fluttertoast.showToast(msg: "Location Permission is permanently denied. Please enable it from settings.");
    return;
  }
  await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
    forceAndroidLocationManager: true,
  ).then((Position position){
    if(mounted){
setState(() {
  _currentPosition=position;
  _getAddressFromLocation();
});}
  }).catchError((e){
    Fluttertoast.showToast(msg: e.toString());
  });
}
  _getAddressFromLocation()async{
  try{
    List<Placemark> placemarks=await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude);
    Placemark place =placemarks[0];
    if(mounted){
    setState(() {
      _currentAddress="${place.locality}${place.postalCode},${place.street}";
    });}
  }catch(e){
Fluttertoast.showToast(msg: e.toString());
  }
  }


 getRandomQuote(){
  Random random = Random();
  setState(() {
     qIndex =random.nextInt(4);        
  });
 }
 getandsendSms()async{
  List<TContact> contactList=await DatabaseHelper().getContactList();
                  if(_currentPosition==null){
                    Fluttertoast.showToast(msg: "GEt Location First");
                  }
                  else
{                  String messageBody="https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}";
                  if(await _isPermissionGranted()){
                   contactList.forEach((element){
                    _sendSms("${element.number}", "I am in trouble pleace reach me out at $messageBody");
                   });

                  }else{

                    Fluttertoast.showToast(msg: "Something Wrong");
                  }
}
 }
//  String? nameuser;
//  String? gmail;
 
// Future<void> getName() async {
//   await FirebaseFirestore.instance.collection('users')
//   .get().then((value) {
//     setState(() {
//       nameuser=value.docs.first['name'];
//   gmail=value.docs.first['childEmail'];
//     });
    
//   });
// }


 @override

 void initState() {
  //  getName();
    // TODO: implement initState
    getRandomQuote();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          
          elevation: 1,
          title: Center(
            child: Text("BINT-E-HAWWA",style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),),
          ),
          
        ),
        body:SafeArea(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              
            children: [
             
             Column(
                 
                  children: [
                     Text("Quran Verses",style: TextStyle(
                fontSize: 16,
                color:  secondaryColor,
                fontWeight: FontWeight.bold,
              ),),
                    CustomAppBar(
                    quoteIndex: qIndex,
                    onTap: (){
                      getRandomQuote();
                    }
                    ),
                  ],
                ),
             
              Expanded(child: ListView(
               shrinkWrap: true,
               children: [
                CustomCarousel(),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Emergency Calls",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                Emergency(),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Explore LiveSafe",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                LiveSafe(),
                
                SafeHome(),
               ],
              ))
             
            ],
                  ),
          )
      )),
    );
  }
}