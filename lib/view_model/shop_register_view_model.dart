import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../model/bank_model.dart';
import '../model/shop_model.dart';
import '../model/user_model.dart';

class AuthenticationOtpViewModel with ChangeNotifier {
  bool _isAuthenticated = false;
  ShopModel? _shopInfor;
  bool get isOtpAuthenticated => isOtpAuthenticated;

  void setOtpAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  ShopModel? get shopInfor => _shopInfor;

  Future<void> initializeShopInfor(
      String idShop,
      String nameShop,
      String passShop,
      BankModel bankmModel,
      String rmCode,
      UserModel userModel) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _shopInfor = ShopModel(
      idShop: _generateId(),
      nameShop: nameShop,
      passShop: passShop,
      bankModel: bankmModel,
      rmCode: rmCode,
      userModel: userModel,
    );
    notifyListeners();
  }
}

String _generateId() => '${Random().nextInt(900000) + 100000}';
