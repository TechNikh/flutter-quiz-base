import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/pages/welcome_page.dart';

Future main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.libreBaskervilleTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent.shade700),
      ),
      home: const WelcomePage(),
    );
  }
}
