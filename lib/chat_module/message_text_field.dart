import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wsfty_apk/utils/constants.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;
  
  const MessageTextField({
    super.key,
    required this.currentId,
    required this.friendId,
  });

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
   Position? _currentPosition;
 String? _currentAddress;
 String? message;
  LocationPermission? permission;
  File? imageFile;
  final supabase =Supabase.instance.client;
  List<String> ImageUrls =[];

  TextEditingController _controller = TextEditingController();
  Future getimage()async{
    ImagePicker _picker
=ImagePicker();

await _picker.pickImage(source: ImageSource.gallery).then((XFile? XFile){
  if(XFile!=null){
    imageFile=File(XFile.path);
    uploadImage(context);
  }
});  }
  Future<void> getImageFromCamera(BuildContext context) async {
  try {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      uploadImage(context);
    } else {
      Fluttertoast.showToast(msg: "No image captured.");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Camera error: $e");
  }
}
Future<void> uploadImage(BuildContext context) async {
  try {
   if (imageFile == null) throw Exception("No image file found");
      final  fileBytes = await imageFile!.readAsBytes();
      final String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";

      // Upload the file
       await supabase.storage.from("images").uploadBinary(fileName, fileBytes);

      // Get the public URL
      final String imageUrl =
         await supabase.storage.from("images").getPublicUrl(fileName);
final String url=imageUrl.toString();
      // Send the image URL as message
      await sendMessage(url, 'img');
    }
   catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed: $e"), backgroundColor: Colors.red),
    );
    Fluttertoast.showToast(msg: "Error Sending Image");
  }
}

// Future<void> uploadImage()async{
//   try{
//     final imagepicker= ImagePicker();
//   final pickedfile=await imagepicker.pickImage(source: ImageSource.gallery);

//   if(pickedfile!=null){
//     final Uint8List filebytes= await pickedfile.readAsBytes();
    
//     final String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
//     var ref = await supabase.storage.from("images").uploadBinary(fileName, filebytes);
//   try{
//   final files= await supabase.storage.from("images").list();
//   final String imgurl = await supabase.storage.from("images").getPublicUrl(fileName);
//   await sendMessage(imgurl, 'img');
//   }catch(e){
//  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed:   $e"),backgroundColor: Colors.red,));
//     Fluttertoast.showToast(msg: "Error Sending Image");
//   }

//       }
//   } catch(e){
//      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed:   $e"),backgroundColor: Colors.red,));
//     Fluttertoast.showToast(msg: "Error Sending Image");
//   }
  

  Future _getCurrentLocation()async{

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
  sendMessage(String message,String type)async{
                      

    await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.currentId)
                      .collection('messages')
                      .doc(widget.friendId)
                      .collection('chats')
                      .add({
                        'senderId': widget.currentId,
                        'receiverId': widget.friendId,
                        'message': message,
                        'type': type,
                        'date': DateTime.now(),
                      });
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.friendId)
                      .collection('messages')
                      .doc(widget.currentId)
                      .collection('chats')
                      .add({
                        'senderId': widget.currentId,
                        'receiverId': widget.friendId,
                        'message': message,
                        'type': type,
                        'date': DateTime.now(),
                      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),

        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                cursorColor: secondaryColor,
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Type Message here",
                  fillColor: Colors.grey[100],
                  filled: true,
                  prefixIcon: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => bottomsheet(),
                      );
                    },
                    icon: Icon(Icons.add_box, color: secondaryColor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: InkWell(
                onTap: () async {
                  message=_controller.text;
                  _controller.clear();
                  sendMessage(message!, 'text');
                },
                child: Icon(Icons.send, color: secondaryColor, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bottomsheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  chatsIcon(Icons.location_pin, "location", () async{
                   await  _getCurrentLocation();
                    Future.delayed(Duration(seconds: 2),(){
                       message="https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}";
                    sendMessage(message!, 'link');
                    });
                   
                  }),
                  chatsIcon(Icons.camera_alt, "Camera", () =>
                      getImageFromCamera(context),
                  ),
                  chatsIcon(Icons.insert_photo, "Photo", ()=>
getimage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  chatsIcon(IconData icons, String title, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: primaryColor,
            child: Icon(icons, color: Colors.white),
          ),
          Text("$title"),
        ],
      ),
    );
  }
}
