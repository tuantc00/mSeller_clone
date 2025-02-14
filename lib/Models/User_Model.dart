class UserModel {
  String phone;
  String token;
  String storedOTP;

  UserModel({
    required this.phone,
    required this.token,
    required this.storedOTP,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        phone: json['phone'], token: json['token'], storedOTP: json['otp']);
  }
}
