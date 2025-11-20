import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wsfty_apk/Screen/parent_home.dart';
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
    url: '',
    anonKey:
        '',
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
