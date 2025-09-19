import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wsfty_apk/chat_module/message_text_field.dart';
import 'package:wsfty_apk/chat_module/singleMessage.dart';
import 'package:wsfty_apk/utils/constants.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserID;
  final String friendID;
  final String friendName;
  const ChatScreen({
    super.key,
    required this.currentUserID,
    required this.friendID,
    required this.friendName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? type;
  String? myName;

  @override
  void initState() {
    super.initState();
    getStatus();
  }

  Future<void> getStatus() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentUserID)
          .get();

      if (!mounted) return;

      setState(() {
        type = doc.data()?['type'] ?? 'unknown';
        myName = doc.data()?['name'] ?? 'unknown';
      });
    } catch (e) {
      // Handle errors here
      print("Error getting user status: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.person),
            ),
            SizedBox(width: 10,),
            Text(widget.friendName),
          ],
        ),
        actions: [
          Icon(Icons.more_vert,size: 45,)
        ],
      ),
      body: Column(
        children: [
          
          Expanded(

            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.currentUserID)
                  .collection('messages')
                  .doc(widget.friendID)
                  .collection('chats')
                 .orderBy('date',descending: false)
                  .snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
  }

  if (snapshot.hasError) {
    return Center(child: Text('Something went wrong: ${snapshot.error}'));
  }

  if (!snapshot.hasData || snapshot.data == null) {
    return Center(child: Text('No data'));
  }

                if (snapshot.hasData ){if( snapshot.data!.docs.length<1) {
                  return Center(
                    child: Text(type == "parent" ? 'TALK WITH CHILD' : 'TALK WITH PARENT'),
                  );
                } 
                }
            
            try {
  return ListView.builder(
    reverse: false,
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (BuildContext context,int index) {
      final data = snapshot.data!.docs[index];
      bool isMe = data['senderId'] == widget.currentUserID;

      return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction)async{
await FirebaseFirestore.instance.collection('users')
.doc(widget.currentUserID)
.collection('messages')
.doc(widget.friendID)
.collection('chats')
.doc(data.id).delete();
await FirebaseFirestore.instance.collection('users')
.doc(widget.friendID)
.collection('messages')
.doc(widget.currentUserID)
.collection('chats')
.doc(data.id).delete().then((value){
  Fluttertoast.showToast(msg: "Message Deleted Successfully");
});
        },
        child: SingleMessage(
          message: data['message'],
          date: data['date'],
          isMe: isMe,
          friendName: widget.friendName,
          myName: myName,
          type: data['type'],
        ),
      );
     
    },
    
  );
} catch (e) {
  print("Error in ListView: $e");
  return Center(child: Text("Error displaying messages"));
}
              },
            ),
          ),
        MessageTextField(currentId: widget.currentUserID,friendId: widget.friendID,),
        ],
      ),
    );
  }
}
