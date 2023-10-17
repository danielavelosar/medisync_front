import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prueba_64/presentation/screens/home_page.dart';
import 'package:prueba_64/presentation/screens/login_page.dart';
import 'package:prueba_64/presentation/screens/welcome_page.dart';
import 'package:prueba_64/presentation/widgets/dropdown_specialties.dart';

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
              primary: Color.fromRGBO(0, 78, 174, 1),
              secondary: Color.fromRGBO(0, 78, 174, 1),
              surface: const Color.fromARGB(255, 10, 166, 150),
              background: Color.fromARGB(255, 239, 243, 243),
              error: Color.fromARGB(255, 255, 0, 0),
              onPrimary: Color.fromARGB(255, 135, 195, 189),
              onSecondary: Color.fromRGBO(0, 78, 174, 1),
              onSurface: Color.fromRGBO(1, 34, 73, 1),
              onBackground: const Color.fromARGB(255, 188, 216, 214),
              onError: Color.fromARGB(255, 34, 110, 103),
              brightness: Brightness.light),
          useMaterial3: true,
          textTheme: TextTheme(
              titleLarge: TextStyle(
                fontFamily: GoogleFonts.karla().fontFamily,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
              titleMedium: TextStyle(
                fontFamily: GoogleFonts.karla().fontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              titleSmall: TextStyle(
                  fontFamily: GoogleFonts.karla().fontFamily,
                  fontSize: MediaQuery.of(context).size.width > 800 ? 16 : 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              labelSmall: TextStyle(
                  fontFamily: GoogleFonts.karla().fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 10, 166, 150))),
          fontFamily: GoogleFonts.karla().fontFamily,
        ),
        //home: const LoginPage());
        home: const LoginPage());
  }
}
