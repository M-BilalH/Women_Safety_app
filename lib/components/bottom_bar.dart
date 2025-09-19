import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wsfty_apk/Screen/child_screens/add_contacs.dart';
import 'package:wsfty_apk/Screen/child_screens/chat_page.dart';
import 'package:wsfty_apk/Screen/child_screens/contact_page.dart' show ContactPage;
import 'package:wsfty_apk/Screen/child_screens/profile_page.dart';
import 'package:wsfty_apk/Screen/child_screens/home_screen.dart';
import 'package:wsfty_apk/Screen/parent_screens/parent_chat_page.dart';
import 'package:wsfty_apk/utils/constants.dart';

class BottomPage extends StatefulWidget {
  final String? type;

  const BottomPage({super.key,required this.type});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int current_index =0;

      List<Widget> pages =[
    HomeScreen(),
    AddContactPage(),
    ChatPage(),
    ProfilePage(),
  ];
      List<Widget> pagesparent =[
    HomeScreen(),
    AddContactPage(),
    PChatPage(),
    ProfilePage(),
  ];
  
   onTapped(int index){
    setState(() {
      current_index=index;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.type=='child'?pages[current_index]:pagesparent[current_index],
      bottomNavigationBar:Container(
      height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: hoverColor, // tab button ripple color when pressed
            hoverColor: primaryColor, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15, 
            tabActiveBorder: Border.all(color: primaryColor, width: 1), // tab button border
            tabBorder: Border.all(color:secondaryColor, width: 1), // tab button border
            tabShadow: [BoxShadow(color: primaryColor.withOpacity(0.1), blurRadius: 8)], // tab button shadow
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 300), // tab animation duration
            gap: 8, // the tab button gap between icon and text 
            color: secondaryColor, // unselected icon color
            activeColor: primaryColor, // selected icon and text color
            iconSize: 20, // tab button icon size
            tabBackgroundColor: primaryColor.withOpacity(0.1), // selected tab background color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // navigation bar padding
            tabs: [
              GButton(
          icon: Icons.home,
          text: 'Home',
              ),
              GButton(
          icon: Icons.contacts,
          text: 'Contacts',
              ),
              GButton(
          icon: Icons.chat,
          text: 'Chat',
              ),
              GButton(
          icon: Icons.person,
          text: 'Profile',
              )
            ],
            selectedIndex: current_index,
          onTabChange: onTapped,
          ),
        ),
      )
      // BottomNavigationBar(
        
      //   backgroundColor: Colors.white,
      //   selectedItemColor: primaryColor,
      //   elevation: 5,
      //   onTap: onTapped,
      //   currentIndex: current_index,
      //   type: BottomNavigationBarType.fixed,
      //   showSelectedLabels: true,
      //   selectedIconTheme: IconThemeData(size: 25),
      
      //   items: [
      //   BottomNavigationBarItem(
      //     label: 'Home',
      //     icon: Icon(Icons.home,)),
      //   BottomNavigationBarItem(label: 'Contacts',icon: Icon(Icons.contacts,)),
      //   BottomNavigationBarItem(label: 'Chat',icon: Icon(Icons.chat,)),
      //   BottomNavigationBarItem(label: 'Profile',icon: Icon(Icons.person,)),
      // ]),
    );
  }
}