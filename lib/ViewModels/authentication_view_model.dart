import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mseller/Models/User_Model.dart';

class authenticationViewModel with ChangeNotifier {
  bool _isAuthenticated = false;
  UserModel? _user;
  bool get isAuthenticated => _isAuthenticated;
  UserModel? get user => user;

  Future<void> login(String phone, String password, String otp) async {
    await Future.delayed(const Duration(seconds: 2));
    _user = UserModel(phone: phone, token: password, storedOTP: '');
    _isAuthenticated = true;
    notifyListeners();
  }

  void initializeUser(String phone, String password, String otp) {
    _user = UserModel(phone: phone, token: password, storedOTP: otp);
    notifyListeners();
  }

  Future<void> sendOTP() async {
    await Future.delayed(const Duration(seconds: 2));
    _user?.storedOTP = _generateOTP();
    notifyListeners();
  }

  String _generateOTP() => '${Random().nextInt(900000) + 100000}';
  void logout() {
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
