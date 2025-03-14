import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view/barcode_scan_screen.dart';
import '../view/login_screen.dart';
import '../view/otp_screen.dart';
import '../view/package_screen.dart';
import '../view/phone_number_screen.dart';
import '../view/shop_input_infor_screen.dart';
import '../view/splash_screen.dart';
import '../view_model/authentication_view_model.dart';
import '../view_model/branches_view_model.dart';
import '../view_model/package_view_model.dart';

class AppRoute {
  // Route names
  static const String login = '/login';
  static const String phone = '/phone';
  static const String otpcode = '/otpcode';
  static const String splash = '/splash';
  static const String shopinput = '/shopinput';
  static const String packageinfor = '/package';
  static const String barcodescan = '/barcode';

  // Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => AuthenticationViewModel(),
            child: LoginScreen(),
          ),
        );
      case phone:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => AuthenticationViewModel(),
            child: PhoneNumberScreen(),
          ),
        );
      case otpcode:
        return MaterialPageRoute(
          builder: (settings) => ChangeNotifierProvider(
            create: (context) => AuthenticationViewModel(),
            child: OtpScreen(),
          ),
          settings: settings,
        );
      case shopinput:
        return MaterialPageRoute(builder: (_) => const ShopInputInforScreen());
      case packageinfor:
        return MaterialPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => PackageViewModel()),
              ChangeNotifierProvider(create: (context) => BranchesViewModel()),
            ],
            child: PackageScreen(),
          ),
        );
      case barcodescan:
        return MaterialPageRoute(builder: (_) => const BarcodeScanScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  // Navigate to a route
  // static void navigateTo(BuildContext context, String routeName,
  //     {required Map agruments}) {
  //   Navigator.pushNamed(context, routeName, arguments: agruments);
  // }

  // Replace current route with a new one
  static void replaceWith(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }
}
