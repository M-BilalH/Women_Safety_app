import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wsfty_apk/Screen/login_screen.dart';
import 'package:wsfty_apk/chat_module/chat_screen.dart';
import 'package:wsfty_apk/utils/constants.dart';

class ChatPage  extends StatelessWidget {
  // const ChatPage ({super.key});
final User =FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.grey[200],
      
      appBar: AppBar(
        backgroundColor:Colors.white,
        title: Center(child: Text("Select Guardian")),
    ),
      body: StreamBuilder(
        
        stream: FirebaseFirestore.instance.collection('users')
        .where('type',isEqualTo: 'parent').where('childEmail',isEqualTo: FirebaseAuth.instance.currentUser!.email)
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
    padding: const EdgeInsets.all(10.0),
    child: Container(
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder:(context)=>ChatScreen(currentUserID:User!.uid, 
          friendID: d.id, friendName: d['name'])));
        },
        trailing: Icon(Icons.arrow_right_alt_sharp),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(d['name'],style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    ),
  );
});
      })
      );
  }
}