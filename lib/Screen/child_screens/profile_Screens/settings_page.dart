import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wsfty_apk/Screen/child_screens/profile_Screens/about.dart';
import 'package:wsfty_apk/components/textfield.dart';
import 'package:wsfty_apk/utils/constants.dart';


class SettingsPage extends StatefulWidget {
  final String? username;
  final String? gmail;
  final String? phone;
  final String? type;
  final String? profilepic;
  SettingsPage({
    super.key,
    required this.username,
    required this.gmail,
    required this.phone,required this.type, required this.profilepic,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
void initState() {
  super.initState();
  _checkServiceStatus();
}

void _checkServiceStatus() async {
  if(_switchValuebs==null){
   _switchValuebs=false;
  }
  bool running = await service.isRunning();
  setState(() {
    _switchValuebs = running;
  });
}


  bool  _switchValuedk=false;
    
 final service = FlutterBackgroundService();
bool?  _switchValuebs= null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomTextField(
                  hintText: "Search Settings",
                  prefix: Icon(Icons.search),
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,bottom: 10),
                child: Text("Accounts",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                         padding:const EdgeInsets.only(left: 15,right: 15,top: 5),
                         child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(widget.profilepic!),
                          ),
                          trailing: Icon(Icons.check_circle_rounded,color: Colors.green,),
                          dense: true,
                          visualDensity: VisualDensity(vertical: 4),
                          title: Text("${widget.username}",style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                           
                          ),),
                          subtitle: Text("${widget.gmail}"),
                         
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                              
                            ),
                         tileColor: Colors.white,
                         
                         selected: true,
                         selectedTileColor: primaryColor.withOpacity(0.2),
                         ),
                       ),
                       Padding(
                padding: const EdgeInsets.only(left: 30,bottom: 10,top: 20),
                child: Text("Settings",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),),
              ),
                 Container(
                 child: Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15),
                       child: ListTile(
                     onTap:(){ Fluttertoast.showToast(msg: "Coming Soon");},
                        leading: Icon(Icons.language_rounded),
                        trailing: Icon(Icons.arrow_forward_ios,color: primaryColor,),
                        title: Text("Languages",style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                      
                        ),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10)
                          ),
                        tileColor: Colors.white,
                       ),
                     ),
                     
                     Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
                       child: Container(
                         child: ListTile(
                          
                          leading: Icon(Icons.vibration_rounded),
                        trailing: CupertinoSwitch(
                value: _switchValuebs!,
              
                onChanged:(value){
                  setState(() {
      
    if (value== false) {
      // Send stop signal
      service.invoke('stopService');
      Fluttertoast.showToast(msg: "Service Stopped");
      print("Service Stopped");
      _switchValuebs=false;
    } else {
      // Restart service if needed
     service.startService();
      Fluttertoast.showToast(msg: "Service Started");
     print("Service Running");
     _switchValuebs=true;
    }
    });
                },
                activeTrackColor:secondaryColor,
              ),
                        title: Text("Shake Feature",style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                      
                        ),),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10)
                          ),
                          tileColor: Colors.white,
                         ),
                       ),
                     ),
                     
                     Padding(
                       padding:const EdgeInsets.only(left: 15,right: 15,top: 5),
                       child: ListTile(
                        leading: Icon(Icons.design_services_rounded,),
                        trailing: CupertinoSwitch(
                value: _switchValuebs!,
                onChanged: (value){
                  
                },
                activeTrackColor:secondaryColor,
              ),
                        title: Text("Background Services",style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                         
                        ),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10)
                          ),
                       tileColor: Colors.white,
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
                       child: ListTile(
                       
            
                        leading: Icon(Icons.mode_night_rounded),
                        trailing:CupertinoSwitch(
                value: _switchValuedk,
                onChanged: (value) {
                  setState(() {
                    _switchValuedk = value;
                    Fluttertoast.showToast(msg: "Coming Soon");
                  });
                },
                activeTrackColor: secondaryColor,
               
              ),
                        title: Text("Dark Mode",style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                      
                        ),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10)
                          ),
                       tileColor: Colors.white,
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
                       child: ListTile(
                       onTap: ()async{
                        String num= '923304149560';

  String url='https://wa.me/$num?text=${Uri.encodeComponent('Hi Developer, I am Facing an error in Application can u plz help me ')}';
  await launchUrl(Uri.parse(url));

                       },
            
                        leading: Icon(Icons.help),
                        trailing: Icon(Icons.arrow_forward_ios,color: primaryColor,),
                        title: Text("Help",style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                      
                        ),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10)
                          ),
                       tileColor: Colors.white,
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
                       child: ListTile(
                       onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutPage()));
                       },
            
                        leading: Icon(Icons.question_answer),
                        trailing: Icon(Icons.arrow_forward_ios,color: primaryColor,),
                        title: Text("About",style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                      
                        ),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10)
                          ),
                       tileColor: Colors.white,
                       ),
                     ),
                     SizedBox(height: 30,),
                     InkWell(
                      onTap:(){ Fluttertoast.showToast(msg: "New Version : App Crashes Fixed");},
                       child: Text("App Version : 1.0.7",style: TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.grey[500]
                       ),),
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