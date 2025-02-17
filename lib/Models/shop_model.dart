import 'package:mseller/Models/user_model.dart';


class ShopModel {
  String nameShop;
  String tokenShop;
  String inforShop;
  UserModel userModel;


  ShopModel({
    required this.nameShop,
    required this.tokenShop,
    required this.inforShop,
    required this.userModel,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
        nameShop: json['phone'], tokenShop: json['token'], inforShop: json['infor'],userModel: json['user']);
  }

  @override
  String toString() {
    return 'ShopModel{nameShop: $nameShop, tokenShop: $tokenShop, inforShop: $inforShop}';
  }
}