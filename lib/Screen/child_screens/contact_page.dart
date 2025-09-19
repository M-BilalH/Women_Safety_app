import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wsfty_apk/db/db_services.dart';
import 'package:wsfty_apk/model/contact_model.dart';
import 'package:wsfty_apk/utils/constants.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  DatabaseHelper _databaseHelper=DatabaseHelper();
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    askPermission();
  }

  String flattenPhoneNumber(String phoneStr) {
    // return "qwerty";
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  filterContact() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((element) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlattern = flattenPhoneNumber(searchTerm);
        String contactName = element.displayName!.toLowerCase();
        bool nameMatch = contactName.contains(searchTerm);
        if (nameMatch == true) {
          return true;
        }
        if (searchTermFlattern.isEmpty) {
          return false;
        }
        var phone = element.phones!.firstWhere((p) {
          String phnFlattered = flattenPhoneNumber(p.number);
          return phnFlattered.contains(searchTermFlattern);
        });
        return phone.number != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  Future<void> askPermission() async {
    PermissionStatus permissionStatus = await getContactsPermission();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContacts();
      searchController.addListener(() {
        filterContact();
      });
    } else {
      handleInvalidP(permissionStatus);
    }
  }

  handleInvalidP(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      dialogbox(context, 'Access denied by user');
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      dialogbox(context, 'Contacts Doesnt Exists');
    }
  }

  Future<PermissionStatus> getContactsPermission() async {
    PermissionStatus permisson = await Permission.contacts.status;
    if (permisson != PermissionStatus.granted &&
        permisson != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permisson;
    }
  }

  getAllContacts() async {
    List<Contact> _contacts = await FlutterContacts.getContacts(withProperties: true,withPhoto: true);

    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearchIng = searchController.text.isNotEmpty;
    bool listItemExit = (contactsFiltered.length > 0 || contacts.length > 0);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body:
            contacts.length == 0
                ? Center(child: CircularProgressIndicator())
                : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: "Search Contacts",
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    listItemExit == true
                        ? Expanded(
                          child: ListView.builder(
                            itemCount:
                                isSearchIng == true
                                    ? contactsFiltered.length
                                    : contacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              Contact contact =
                                  isSearchIng == true
                                      ? contactsFiltered[index]
                                      : contacts[index];

                              return ListTile(
                                title: Text(contact.displayName ?? ''),
                                        subtitle: Text(
                                  contact.phones.elementAt(0).normalizedNumber
                                 
                                ),
                                leading:
                                    (contact.photo != null &&
                                            contact.photo!.isNotEmpty)
                                        ? CircleAvatar(
                                          backgroundImage: MemoryImage(
                                            contact.photo!,
                                          ),
                                        )
                                        : CircleAvatar(
                                          backgroundColor: primaryColor,
                                          child: Text(
                                            contact.displayName[0],
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        onTap: (){
                                          if(contact.phones.length>0){
                                            final String phoneNum = contact.phones.elementAt(0).normalizedNumber;
                                            final String name=contact.displayName!;
_addContact(TContact(name, phoneNum));
                                          }else{
                                            Fluttertoast.showToast(msg: "Phone Number doesnt exist");
                                          }
                                        },
                              );
                            },
                          ),
                        )
                        : Container(child: Text("Searching")),
                  ],
                ),
      ),
    );
  }
  void _addContact(TContact newContact)async{
  int result = await _databaseHelper.insertContact(newContact);
  if(result!=0){
    Fluttertoast.showToast(msg: "Contact added Successfully");
  }else{
    Fluttertoast.showToast(msg: "Failed to add Contact");
  }
  Navigator.of(context).pop(true);
  }
}
