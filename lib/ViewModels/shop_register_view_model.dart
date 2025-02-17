/*
import 'package:flutter/cupertino.dart';

class AuthenticationViewModel with ChangeNotifier {
  bool _isAuthenticated = false;
  UserModel? _user;
  bool get isAuthenticated => _isAuthenticated;
  UserModel? get user => _user;

  Future<void> login(String phone, String password, String otp) async {
    await Future.delayed(const Duration(seconds: 2));
    _user = UserModel(phone: phone, token: password, storedOTP: '');
    _isAuthenticated = true;
    notifyListeners();
  }

  void initializeUser(String phoneNumber) {
    if (_user?.phone != phoneNumber) {
      _user = UserModel(
        phone: phoneNumber,
        token: '',
        storedOTP: generateOTP(),
      );
      notifyListeners();
    }
  }

  Future<void> sendOTP() async {
    await Future.delayed(const Duration(seconds: 2));
    _user?.storedOTP = generateOTP();
    notifyListeners();
  }

  void logout() {
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

}*/
