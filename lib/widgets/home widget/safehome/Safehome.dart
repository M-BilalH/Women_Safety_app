import 'package:another_telephony/telephony.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wsfty_apk/components/primarybutton.dart';
import 'package:wsfty_apk/db/db_services.dart';
import 'package:wsfty_apk/model/contact_model.dart';

class SafeHome extends StatefulWidget {
  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
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
  Geolocator.getCurrentPosition(
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

@override
void initState(){
  super.initState();
  _getPermission();
  _getCurrentLocation();
  
}
  showModel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 40,right: 40,),
            child: Column(
              
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6,bottom: 6),
                  child: Container(
                    decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(50)
                    ),
                    
                    width: 120,
                    height: 8,
                  ),
                ),
              
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text('Send Location & Alerts',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
               
                
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: PrimaryButton(title: 'Send Alerts', onPressed: ()async {
                    List<TContact> contactList=await DatabaseHelper().getContactList();
                    String recipients="";
                    int i=1;
                    for(TContact contact in contactList){
                    recipients+= contact.number;
                    if(i!= contactList.length){
                      recipients+=";";
                      i++;
                    }
                    }
                    String messageBody="https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}";
                    if(await _isPermissionGranted()){
                      _getCurrentLocation();
                     contactList.forEach((element){
                      _sendSms("${element.number}", "I am in trouble pleace reach me out at\n $messageBody");
                     });
                  
                    }else{
                  
                      Fluttertoast.showToast(msg: "Something Wrong");
                    }
                  }),
                ),
               

              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModel(context),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:10,left: 10),
                      child: ListTile(
                        title: Text("Send Location & Alerts",style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        subtitle: Text("Share Location with alert message to all your added trusted contacts in One Click.",style: TextStyle(
                          fontSize: 12
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(child: Image.asset('assets/location.png')),
            ],
          ),
        ),
      ),
    );
  }
}
