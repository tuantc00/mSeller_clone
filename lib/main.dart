import 'package:flutter/material.dart';
import 'package:mseller/Views/LoginScreen.dart';
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
      home: ChangeNotifierProvider(
        create: (context)=> authenticationViewModel(),
        child: Loginscreen(),
      ),
    );
  }
}
