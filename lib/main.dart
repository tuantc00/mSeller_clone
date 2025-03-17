import 'package:flutter/material.dart';
import 'package:mseller/routes/app_route.dart';

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
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'AvertaCY',
            ),
      ),
      initialRoute: AppRoute.barcodescan,
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}
