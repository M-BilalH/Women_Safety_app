import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wsfty_apk/Screen/child_screens/profile_Screens/edit_profile.dart';
import 'package:wsfty_apk/Screen/child_screens/profile_Screens/review_page.dart';
import 'package:wsfty_apk/Screen/child_screens/profile_Screens/settings_page.dart';
import 'package:wsfty_apk/Screen/login_screen.dart';
import 'package:wsfty_apk/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController namecontrol=TextEditingController();
  final key= GlobalKey<FormState>();
  String? id;
  String? profilepic='';
  File? imageFile;
  final supabase =Supabase.instance.client;
  String? downloadurl;
  bool isSaving=false;
  int index=4;
  String? gmail;
  String? phone;
  String? type;
getNAme()async{
  await FirebaseFirestore.instance.collection('users')
  .where('id',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  .get().then((value) {
    setState(() {
      namecontrol.text=value.docs.first['name'];
  id=value.docs.first.id;
  profilepic=value.docs.first['profilepic'];
  phone = value.docs.first['phone'];
  if(value.docs.first['type'] == 'parent'){
    type='parent';
        gmail=value.docs.first['parentEmail'];
      } else{
        type='child';
         gmail=value.docs.first['childEmail'];
      }
  
    });
    
  });
  
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNAme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: 
        
        SafeArea(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
            
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Container(
                        child: 
                        profilepic==null?
                        CircleAvatar(
                          child: Center(child: Icon(Icons.no_photography,size: 40,color: Colors.white,)),
                          radius: 70,
                          backgroundColor: secondaryColor,
                        ):CircleAvatar(
                          backgroundImage: NetworkImage(profilepic!),
                          radius: 70,
                          backgroundColor: secondaryColor,
                        ),
                      ),
                    ),
                   
                   
                  ],
                ),
              ),
              
              
              SizedBox(height: 10,),
              Text(namecontrol.text,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 10,),
              Container(
                height: 50,
                width: 200,
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primaryColor.withOpacity(0.4),
                ),
                child: Center(child: Text('$gmail')),
              ),
              SizedBox(height: 40,),
              Container(
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(left: 15,right: 15),
                     child: ListTile(
                      onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=> EditprofiLe(username: namecontrol.text,
gmail: gmail,
phone: phone,
type: type,
profilepic1: profilepic,
)));
                      },
                      leading: Icon(Icons.edit),
                      trailing: Icon(Icons.arrow_forward_ios,color: primaryColor,),
                      title: Text("Edit Profile",style: TextStyle(
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
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ReviewPage(
)));
                        },
                        leading: Icon(Icons.reviews),
                      trailing: Icon(Icons.arrow_forward_ios,color: primaryColor,),
                      title: Text("See Reviews",style: TextStyle(
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
                      onTap: ()async{
                        
                        String url ='https://wa.me/$num?text=${Uri.encodeComponent('https://drive.google.com/drive/folders/14mHy23btQoUiDeO4K_xPeGO6Ed2QYDeK?usp=drive_link')}';
                       await launchUrl(Uri.parse(url));
                      },
                      leading: Icon(Icons.group_add,),
                      trailing: Icon(Icons.arrow_forward_ios,color: primaryColor,),
                      title: Text("Invite Friends",style: TextStyle(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage(username: namecontrol.text,
gmail: gmail,
phone: phone,
type: type,
profilepic: profilepic!,
)));
                      },
                      leading: Icon(Icons.settings),
                      trailing: Icon(Icons.arrow_forward_ios,color: primaryColor,),
                      title: Text("Settings",style: TextStyle(
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
                     padding:const EdgeInsets.only(left: 15,right: 15,top: 5),
                     child: ListTile(
                      onTap: ()async{

        final prefs = await SharedPreferences.getInstance();
await prefs.clear(); 
          await FirebaseAuth.instance.signOut();
          goto(context, LoginScreen());
                      },
                      leading: Icon(Icons.logout,color: Colors.redAccent),
                      
                      title: Text("Log Out",style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent
                      ),),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10)
                        ),
                     tileColor: Colors.white,
                     ),
                   ),
                 ],
               ),
              ),
             
              
            ],
                        ),
          ),
        )),
      )
    );
  }
 
  
}
// String fileName=Uuid().v1();
  // int status=1;
  // var ref=FirebaseStorage.instance.ref().child('images').child('$fileName.jpg');
  // var uploadTask=await ref.putFile(imageFile!).catchError((e){
  //   status=0;
  //   print(e.toString());
  //   Fluttertoast.showToast(msg: e.toString());
  // });
  // if(status==1){
  //   String imageUrl=await uploadTask.ref.getDownloadURL();
  //   await sendMessage(imageUrl, 'img');
  // }