import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';

class AuthenticationViewModel with ChangeNotifier {
  bool _isAuthenticated = false;
  UserModel? _user;
  bool get isAuthenticated => _isAuthenticated;
  UserModel? get user => _user;

  Future<void> login(String phone, String password, String otp) async {
    await Future.delayed(const Duration(seconds: 2));
    _user = UserModel(phone: phone, pass: password, storedOTP: '');
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> initializeUser(String phoneNumber) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_user?.phone != phoneNumber) {
      _user = UserModel(
        phone: phoneNumber,
        pass: '',
        storedOTP: generateOTP(),
      );
      notifyListeners();
    }
  }

  Future<void> sendOTP() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _user?.storedOTP = generateOTP();
    notifyListeners();
  }

  String generateOTP() => '${Random().nextInt(900000) + 100000}';
  void logout() {
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
