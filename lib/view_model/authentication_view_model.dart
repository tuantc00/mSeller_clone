import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/api_messenger_model.dart';
import '../model/user_model.dart';

class AuthenticationViewModel with ChangeNotifier {
  bool _isAuthenticated = false;
  UserModel? _user;
  ApiMessenger? _apiResponse;

  String? _errorMess;
  String? get errorMess => _errorMess;
  bool get isAuthenticated => _isAuthenticated;
  UserModel? get user => _user;
  ApiMessenger? get apiResponse => _apiResponse;

  Future<void> login(String phoneNumber, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.dev.mseller.vn/api/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': phoneNumber,
          'password': password,
        }),
      );

      final jsonData = jsonDecode(response.body);
      _apiResponse = ApiMessenger.fromJson(jsonData);

      if (response.statusCode == 200) {
        if (_apiResponse!.status == Status.ok && _apiResponse!.userModel != null) {
          _user = _apiResponse!.userModel;
          _isAuthenticated = true;
          _errorMess = null;
          print('Login successful');
        } else {
          _isAuthenticated = true;
          _errorMess = _apiResponse!.title ?? 'Đăng nhập thất bại';
          print('debug: ${_apiResponse!.title}');
        }
      } else {
        _isAuthenticated = false;
        _errorMess = _apiResponse!.title ?? 'Vui lòng nhập lại số điện thoại và mật khẩu';
        print('Login failed: ${response.statusCode} - ${response.body}');
      }

      notifyListeners();
    } catch (e) {
      _isAuthenticated = false;
      _errorMess = 'Lỗi kết nối: Vui lòng thử lại sau';
      print('Error: $e');
      notifyListeners();
    }
  }

  void logout() {
    _isAuthenticated = false;
    _user = null;
    _apiResponse = null;
    _errorMess = null;
    notifyListeners();
  }
}