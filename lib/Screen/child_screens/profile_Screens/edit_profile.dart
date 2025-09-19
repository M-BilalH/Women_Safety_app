import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wsfty_apk/components/primarybutton.dart';
import 'package:wsfty_apk/components/textfield.dart';
import 'package:wsfty_apk/utils/constants.dart';

class EditprofiLe extends StatefulWidget {
  final String? username;
  final String? gmail;
  final String? phone;
  final String? type;
   String? profilepic1;
 
  EditprofiLe({
    super.key,
    required this.username,
    required this.gmail,
    required this.phone,
     required this.type,
     this.profilepic1, 
  });

  @override
  State<EditprofiLe> createState() => _EditprofiLeState();
}

class _EditprofiLeState extends State<EditprofiLe> {
   TextEditingController namecontrol=TextEditingController();
   TextEditingController gmailcontrol=TextEditingController();
   TextEditingController phonecontrol=TextEditingController();

  final key= GlobalKey<FormState>();

  final supabase =Supabase.instance.client;
  String? downloadurl;  
  bool isSaving=false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("UPDATE PROFILE"),
      ),
      body:isSaving==true?Center(
        child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
      ):
      SafeArea(
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  Container(
                height: 150,
                width: 150,
            
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: GestureDetector(
                        onTap: ()async{
                          final XFile? pickImage=await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50);
                          if(pickImage!=null){
                            setState(() {
                             widget.profilepic1=pickImage.path;
                            });
                            
                          }
                        },
                        child: Container(
                          child: 
                          widget.profilepic1==null?
                          CircleAvatar(
                            child: Center(child: Icon(Icons.add_a_photo,size: 40,color: Colors.white,)),
                            radius: 70,
                            backgroundColor: secondaryColor,
                          ):widget.profilepic1!.contains('http')? CircleAvatar(
                            backgroundImage: NetworkImage(widget.profilepic1!),
                            radius: 70,
                            backgroundColor: secondaryColor,
                          ):CircleAvatar(
                            backgroundImage: FileImage(File(widget.profilepic1!)),
                            radius: 70,
                            backgroundColor: secondaryColor,
                          ),
                        ),
                      ),
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.only(top: 50,),
                      child: Align(
                        alignment: Alignment.centerRight,
                                      widthFactor: .1,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 18,
                                        child: CircleAvatar(
                      backgroundColor: primaryColor,
                      child: Icon(Icons.edit,color: Colors.white,),
                      radius: 16,
                      
                                        ),
                                      ),
                                    ),
                    ),
                  ],
                ),
              ),
              
                //  Padding(
                //    padding: const EdgeInsets.only(bottom: 10),
                //    child: Container(
                //           width: MediaQuery.of(context).size.width,
                //           child: Padding(
                //             padding: const EdgeInsets.only(top: 10),
                //             child: Row(
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 20),
                //                   child: Image.asset(
                //                     'assets/logoimage.png',
                //                     height: 120,
                //                     width: 120,
                //                   ),
                //                 ),
                //                 Column(
                //                   children: [
                //                     Text(
                //                       'BINT-E-HAWWA',
                //                       style: TextStyle(
                //                         color: primaryColor,
                //                         fontSize: 30,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                     Text(
                //                       'Every Daughter Protected.',
                //                       style: TextStyle(
                //                         color: secondaryColor,
                //                         fontSize: 16,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //  ),
                //    SizedBox(height: 40,), 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  
                        Padding(
                          padding: const EdgeInsets.only(left: 25,bottom: 5),
                          child: Text("Username :",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: CustomTextField(
                                      controller: namecontrol,
                                      hintText: widget.username,
                                      
                                      validate: (v){
                                        if(v!.isEmpty){
                                          return 'Enter Updted name';
                                        }
                                      },
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  
                        Padding(
                          padding: const EdgeInsets.only(left: 25,bottom: 5),
                          child: Text("Email :",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: CustomTextField(
                                      controller: gmailcontrol,
                                      hintText: widget.gmail,
                                      validate: (v){
                                        if(v!.isEmpty){
                                          return 'Enter Updted name';
                                        }
                                      },
                                     
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  
                        Padding(
                          padding: const EdgeInsets.only(left: 25,bottom: 5),
                          child: Text("Phone :",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: CustomTextField(
                                      controller: phonecontrol,
                                      hintText: widget.phone,
                                      
                                      validate: (v){
                                        if(v!.isEmpty){
                                          return 'Enter Updted Phone Number';
                                        }
                                      },
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                           SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: PrimaryButton(title: "Update Profile", onPressed: ()async{
                              if(key.currentState!.validate()){
                                SystemChannels.textInput.invokeMethod('TextInput.hide');
                                update();
                              }
                                              
                            }),
                          ),
                
                ],),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline,color: Colors.redAccent,size: 40,),
                      Text("If You Want to Keep the Same Name,Gmail\n or Phone Same You have to REWRITE it"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }


  update(){
    setState(() {
      isSaving=true;
    });
  uploadImage(widget.profilepic1!).then((value){
    if(widget.type=="child"){
    Map<String,dynamic> data= {
'name':namecontrol.text,
'phone':phonecontrol.text,
'childEmail':gmailcontrol.text,
'profilepic': downloadurl,
    };
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(data);
    setState(() {
      isSaving=false;
    });} else{
       Map<String,dynamic> data= {
'name':namecontrol.text,
'phone':phonecontrol.text,
'parentEmail':gmailcontrol.text,
'profilepic': downloadurl,
    };
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(data);
    setState(() {
      isSaving=false;
    });
    }
  });
  
  }
  Future<String?>uploadImage(String imagepath)async{
  try {
   
      final  fileBytes = await File(imagepath).readAsBytes();
      final String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
   final path= '/profile/$fileName';
     
       await supabase.storage.from("images").uploadBinary(path, fileBytes);

     
      final String imageUrl =
         await supabase.storage.from("images").getPublicUrl(path);
downloadurl=imageUrl.toString();
    
  return downloadurl;
    }
   catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed: $e"), backgroundColor: Colors.red),
    );
    Fluttertoast.showToast(msg: "Error Sending Image");
  }
return '';
  }
}
