import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wsfty_apk/Screen/login_screen.dart' show LoginScreen;
import 'package:wsfty_apk/components/secondarybutton.dart';
import 'package:wsfty_apk/chat_module/chat_screen.dart';
import 'package:wsfty_apk/utils/constants.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

        child: Column(
          children: [
            DrawerHeader(child: Container()),
            ListTile(
              title: TextButton(onPressed: ()async{

        try{
          await FirebaseAuth.instance.signOut();
          goto(context, LoginScreen());
        }on FirebaseAuthException catch(e){
      dialogbox(context, e.toString());
        }
      }, child: Text("Sign Out")),),
            
          ],
        ),
      ),
      
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Center(child: Text("Select Child")),
    ),
      body: StreamBuilder(
        
        stream: FirebaseFirestore.instance.collection('users')
        .where('type',isEqualTo: 'child').where('parentEmail',isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots()
      , builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return Center(child: progressIndicator(context),);
        }
return ListView.builder(
  itemCount: snapshot.data!.docs.length,
  itemBuilder: (BuildContext context,int index){
    final d= snapshot.data!.docs[index];
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      color: secondaryColor,
      child: ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen(currentUserID:FirebaseAuth.instance.currentUser!.uid, 
          friendID: d.id, friendName: d['name'])));},
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(d['name']),
        ),
      ),
    ),
  );
});
      })
    );
  }
}