import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "📱 Binte Hawwa – Empowerment, Safety & Spiritual Growth in One App.\nBinte Hawwa is an all-in-one mobile application designed to empower, protect, and inspire. Built with a focus on both safety and spiritual well-being, the app combines essential emergency features with Islamic content and smart customization options to serve as a trusted companion for women and girls.\n🕌 Key Features\n📖 Islamic Articles\nDive into a rich collection of Islamic writings and motivational content curated to guide and uplift your soul. Stay connected with your faith through regularly updated articles.\n🚨 Emergency Safety Tools\n📍 Send Location Instantly\nWith just one tap, send your real-time location via SMS to all your added emergency contacts, along with a direct Google Maps link.\n📞 Emergency Call\nCall an emergency helpline instantly from the app in any crisis.\n🤳 Shake Detection with Background Service\nEnable shake-to-alert — shake your phone to automatically send your location and trigger emergency SMS alerts even when the app is in the background.\n👥 Guardian and Contact Features\n📇 Add Trusted Contacts\nSave guardians and emergency contacts in-app who will receive alerts and your location in times of distress.\n💬 In-App Chat with Guardian\nStay in touch with your guardian or emergency contact through built-in messaging within the app for quicker communication.\n🧑‍💼 Profile Management\n✏️ Edit Profile\nEasily update your name, Gmail, phone number, and profile picture through a simple and intuitive interface.\n🌗 Smart Display Customization\n🌓 Dark Mode\nSwitch between light and dark themes for a more personalized and comfortable user experience, especially at night.\n⚙️ Custom Settings & Control\n- Enable or disable background shake detection.\n- Manually toggle the emergency background service.\n- Manage your contact list and keep it up to date.\n🔒 Built for Your Safety. Inspired by Your Faith.\nWhether you're looking for spiritual enrichment or emergency protection, Binte Hawwa brings both into a single, secure, and user-friendly platform."
                  ,style: TextStyle(fontSize: 16, height: 1.5,wordSpacing: 2,fontWeight: FontWeight.bold),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("This Application is Designed and Developed by",style: TextStyle(
                  fontSize: 16,
                  height: 1,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text("Syed Bilal",style: TextStyle(
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              )
                
                
                            
              ],
          ),
              
        ),
      ),
    );
  }
}
