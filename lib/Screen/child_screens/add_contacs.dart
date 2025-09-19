
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wsfty_apk/Screen/child_screens/contact_page.dart';
import 'package:wsfty_apk/db/db_services.dart';
import 'package:wsfty_apk/model/contact_model.dart';
import 'package:wsfty_apk/utils/constants.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<TContact>? contactList = [];
  int count = 0;

  void showList() {
    // Future<Database> dbFuture = databaseHelper.initializeDatabase();
    Future<List<TContact>> contactListFuture = databaseHelper.getContactList();
    contactListFuture.then((value) {
      setState(() {
        this.contactList = value;
        this.count = value.length;
      });
    });
  }

  void deleteContact(TContact contact) async {
    int result = await databaseHelper.deleteContact(contact.id);
    if (result != 0) {
      Fluttertoast.showToast(msg: 'Contact removed Successfully');
      showList();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Timestamp) {
      showList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:
            contactList!.isEmpty
                ? BoxDecoration(
                  color: Colors.grey[200],
                  image: DecorationImage(
                    image: AssetImage('assets/contact.png'),
                    fit: BoxFit.scaleDown,
                    filterQuality: FilterQuality.medium,
                    opacity: 0.2,
                  ),
                )
                : BoxDecoration(color:Colors.grey[200],),
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 10,right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logoimage.png',
                      height: 100,
                      width: 100,
                    ),
                    Column(
                      children: [
                        Text(
                          'BINT-E-HAWWA',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Every Daughter Protected.',
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: count,
                // shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(contactList![index].name),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: ()async {
                                  await FlutterPhoneDirectCaller.callNumber(contactList![index].number);
                                },
                                icon: Icon(Icons.call, color: Colors.green),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteContact(contactList![index]);
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            contactList!.isEmpty
                ? Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.info, color: Colors.redAccent),
                        SizedBox(width: 10),
                        Text(
                          'No Contacts to show',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                : Text(''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add Trusted Contacts :',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: 40,
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () async{
                        bool? result =await Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactPage()));
                        if (result == true) {
                         showList();
                      }},
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff888DF2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
               
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
