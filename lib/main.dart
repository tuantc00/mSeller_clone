import 'package:flutter/material.dart';
import 'package:mseller/Views/login_screen.dart';
import 'package:mseller/Views/otp_screen.dart';
import 'package:mseller/Views/phone_number_screen.dart';
import 'package:mseller/Views/splash_screen.dart';
import 'package:provider/provider.dart';

import 'ViewModels/authentication_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mseller_clone",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      initialRoute: '/login',
      routes: {
        //  '/splashcreen':(context)=>SplashCreen(),
        '/login': (context) => ChangeNotifierProvider(
              create: (context) => AuthenticationViewModel(),
              child: LoginScreen(),
            ),
        '/otpcode': (context) => Otpscreen(),
        '/phone': (context) => ChangeNotifierProvider(
              create: (context) => AuthenticationViewModel(),
              child: Phonenumberscreen(),
            ),
      },
    );
  }
}
