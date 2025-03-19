import 'package:mseller/model/user_model.dart';

import 'bank_model.dart';


// class UserModel{
//   final String id;
//   final String phoneNumber;
//   final String fullName;
//
// }

class ShopModel {
  String idShop;
  String nameShop;
  String passShop;
  BankModel bankModel;
  UserModel userModel;
  String? rmCode;

  ShopModel({
    required this.idShop,
    required this.nameShop,
    required this.passShop,
    required this.bankModel,
    required this.userModel,
    required String rmCode,
  });

  factory ShopModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException('Null Json provided');
    }
    if (!json.containsKey('idShop') ||
        !json.containsKey('pass') ||
        !json.containsKey('name') ||
        !json.containsKey('') ||
        !json.containsKey('pass') ||
        !json.containsKey('pass')) {
      throw const FormatException(
          ' Json is missing required keys: phone, token or otp');
    }
    return ShopModel(
      nameShop: json['phone'],
      passShop: json['token'],
      idShop: json['otp'],
      userModel: json['user'],
      bankModel: json[''],
      rmCode: '',
    );
  }

  @override
  String toString() {
    return 'ShopModel{idShop: $idShop, nameShop: $nameShop, passShop: $passShop, bankModel: $bankModel, userModel: $userModel, rmCode: $rmCode}';
  }
}
