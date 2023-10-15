import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prueba_64/presentation/screens/home_page.dart';
import 'package:prueba_64/presentation/screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme(
              primary: const Color.fromARGB(255, 10, 166, 150),
              secondary: Color.fromARGB(255, 23, 103, 95),
              surface: const Color.fromARGB(255, 10, 166, 150),
              background: Color.fromARGB(255, 239, 243, 243),
              error: Color.fromARGB(255, 255, 0, 0),
              onPrimary: Color.fromARGB(255, 65, 211, 196),
              onSecondary: Color.fromARGB(255, 14, 87, 79),
              onSurface: Color.fromARGB(255, 127, 176, 171),
              onBackground: const Color.fromARGB(255, 10, 166, 150),
              onError: Color.fromARGB(255, 34, 110, 103),
              brightness: Brightness.light),
          useMaterial3: true,
          textTheme: TextTheme(
              titleMedium: TextStyle(
                  fontFamily: GoogleFonts.karla().fontFamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              labelSmall: TextStyle(
                  fontFamily: GoogleFonts.karla().fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 10, 166, 150))),
          fontFamily: GoogleFonts.karla().fontFamily,
        ),
        home: const LoginPage());
  }
}
