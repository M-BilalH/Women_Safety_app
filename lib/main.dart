import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wsfty_apk/Screen/splash_screen.dart';
import 'package:wsfty_apk/components/bottom_bar.dart';
import 'package:wsfty_apk/db/shared_pref.dart';
import 'package:wsfty_apk/utils/constants.dart';
import 'package:wsfty_apk/utils/flutter_bg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await MySharedPrefferences.init();
  await initializeService();
  await Supabase.initialize(
    url: 'https://uknuebqxoxrlpxnuedqg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVrbnVlYnF4b3hybHB4bnVlZHFnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI3NDg3NTEsImV4cCI6MjA2ODMyNDc1MX0.tiJ_BL82rgcnIdLzm8VOcIm0pEEsgTqj80-VkR2A7u4',
    debug: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BINT-E-HAWWA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.firaSansTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      ),
      home: FutureBuilder(
        future: MySharedPrefferences.getUserType(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == "") {
            return SplashScreen();
          }
          if (snapshot.data == "child") {
            return BottomPage(type: 'child',);
          }
          if (snapshot.data == "parent") {
            return BottomPage(type: 'parent');
          }
          return progressIndicator(context);
        },
      ),
    );
  }
}
