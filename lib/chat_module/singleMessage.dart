import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wsfty_apk/utils/constants.dart';

class SingleMessage extends StatelessWidget {
  final String? message;
  final bool isMe;
  final String? image;
  final String? type;
  final String? friendName;
  final String? myName;
  final Timestamp? date;

  const SingleMessage({
    super.key,
    this.message,
    this.image,
    this.type,
    this.friendName,
    this.myName,
    this.date,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    DateTime? messageTime;
    if (date != null) {
      try {
        messageTime = date!.toDate();
      } catch (e) {
        print("Error parsing date: $e");
      }
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child:
          type == 'text'
              ? 
              Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: EdgeInsets.all(12),
                constraints: BoxConstraints(
                  maxWidth:
                      message!.length < 11
                          ? size.width * 0.3
                          : size.width * 0.6,
                ),
                decoration: BoxDecoration(
                  color: isMe ? hoverColor : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: isMe ? Radius.circular(15) : Radius.circular(0),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        isMe ? myName! : friendName!,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        message!,
                        style: TextStyle(
                          fontSize: 18,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${messageTime!.hour.toString().padLeft(2, '0')}:${messageTime!.minute.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          color: isMe ? secondaryColor: Colors.black54,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              
              :type=='img'?
               Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: EdgeInsets.all(12),
                constraints: BoxConstraints(
                  maxWidth: size.width*0.5,
                ),
                decoration: BoxDecoration(
                  color: isMe ? hoverColor : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: isMe ? Radius.circular(15) : Radius.circular(0),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        isMe ? myName! : friendName!,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CachedNetworkImage(imageUrl: message!,
                      fit: BoxFit.cover,
                      placeholder:(context,url)=> CircularProgressIndicator(),
                      errorWidget:(context,url,error)=>Icon(Icons.error),
                      )
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${messageTime!.hour.toString().padLeft(2, '0')}:${messageTime!.minute.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          color: isMe ? secondaryColor : Colors.black54,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              
              : Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: EdgeInsets.all(12),
                constraints: BoxConstraints(
                  maxWidth:
                      message!.length < 11
                          ? size.width * 0.3
                          : size.width * 0.6,
                ),
                decoration: BoxDecoration(
                  color: isMe ? hoverColor : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: isMe ? Radius.circular(15) : Radius.circular(0),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        isMe ? myName! : friendName!,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () async {
                          await launchUrl(Uri.parse("$message"));
                        },
                        child: Text(
                          message!,
                          style: TextStyle(
                            fontSize: 18,
                            color: secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${messageTime!.hour.toString().padLeft(2, '0')}:${messageTime!.minute.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          color: isMe ?secondaryColor : Colors.black54,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
