import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wsfty_apk/widgets/home%20widget/livesafe/cardslivesafe.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});
static Future<void> openMap(String location) async {
  String googleUrl='https://www.google.com/maps/search/$location';
  final Uri _url = Uri.parse(googleUrl);
  try{
    await launchUrl(_url);
  } catch (e){
    Fluttertoast.showToast(msg: 'Something went wrong! call Emergency Numbers');
  }
}
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          
livesafecard(icon: Icons.local_hospital_sharp,label: "Hospitals",onMapFunction: openMap,label2: 'Hospitals near me',color: Colors.deepOrange,),
livesafecard(icon: Icons.local_pharmacy_sharp,label: "Pharmacies",onMapFunction: openMap,label2: 'Pharmacies near me',color: Colors.green,),
livesafecard(icon: Icons.night_shelter_sharp,label: "Shelters",onMapFunction: openMap,label2: 'Shelters near me',color: Colors.pinkAccent,),
livesafecard(icon: Icons.local_police_sharp,label: "Police Station",onMapFunction: openMap,label2: 'Police Stations near me',color: const Color.fromARGB(255, 10, 34, 169),),
livesafecard(icon: Icons.ev_station_sharp,label: "EV Stations",onMapFunction: openMap,label2: 'EV Stations near me',color: Colors.lightGreen,),
livesafecard(icon: Icons.commute,label: "Stations",onMapFunction: openMap,label2: 'Stations near me',color: Colors.blue,),
        ],
      ),
    );
  }
}