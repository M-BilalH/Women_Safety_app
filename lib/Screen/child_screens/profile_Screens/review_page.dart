

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:wsfty_apk/components/textfield.dart';
import 'package:wsfty_apk/utils/constants.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController locationC=TextEditingController();
  TextEditingController viewsC=TextEditingController();
  bool isLOading=false;
  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return  AlertDialog(
          title: Text("Give Review"),
          content: isLOading==true?CircularProgressIndicator():Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [CustomTextField(
                hintText: "Enter Location",
                controller: locationC,
              ),
              SizedBox(height: 20,),
               CustomTextField(
                hintText: "Enter Review",
                controller: viewsC,
                maxline: 3,
              )],
            ),
          ),
          actions: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      saveReview();
                      locationC.clear();
                      viewsC.clear();
                    },
                   
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff888DF2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                     child: Text(
                      'Save',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                   
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff888DF2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                     child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
         
          ],
        );
      },
    );
  }
saveReview()async{
setState(() {
  isLOading=true
;});
await FirebaseFirestore.instance.collection('reviews').add({
  'location':locationC.text,
  'views':viewsC.text,
}).then((value){
  setState(() {
    isLOading=false;
    Fluttertoast.showToast(msg: "Review Uploaded");
  });
});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PUBLIC REVIEWS"),
      ),
      body:StreamBuilder(stream: FirebaseFirestore.instance.collection('reviews').snapshots(), builder: 
      (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
       
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context,int index){
final data= snapshot.data!.docs[index];
return Padding(
  padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
  child: Container(
    color: Colors.transparent,
    child: ListTile(
       shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10)
                          ),
      tileColor: primaryColor.withOpacity(0.2),
      title: Text(data['location'],style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),),
      subtitle: Text(data['views'],style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal
      ),),
    ),
  ),
);
        });
      }
      ),
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlert(context);
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
