import 'package:flutter/cupertino.dart';
import 'package:mseller/Models/User_Model.dart';

class authenticationViewModel with ChangeNotifier{
  bool _isAuthenticated =false;
  UserModel ?_user;
  bool get isAuthenticated=> _isAuthenticated;
  UserModel? get user =>user;

  Future<void> login(String phone, String password ) async{
    await Future.delayed(const Duration(seconds: 2));
    _user=UserModel(phone: phone,token: password);
    _isAuthenticated =true;
    notifyListeners();
  }
  void logout(){
    _user=null;
    _isAuthenticated =false;
    notifyListeners();
  }
}