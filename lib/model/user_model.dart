class UserModel {
  String phone;
  String pass;
  String storedOTP;

  UserModel({
    required this.phone,
    required this.pass,
    required this.storedOTP,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException('Null Json provided');
    }
    if (!json.containsKey('phone') ||
        !json.containsKey('pass') ||
        !json.containsKey('otp'))
      throw const FormatException(
          ' Json is missing required keys: phone, token or otp');
    return UserModel(
        phone: json['phone'], pass: json['token'], storedOTP: json['otp']);
  }

  @override
  String toString() {
    return 'UserModel{phone: $phone, token: $pass, storedOTP: $storedOTP}';
  }
}

// class Test{
//   final String a;
//
//   Test(this.a);
// }
// class Test2{
//   final String b;
//
//   Test2(this.b);
// }
// class Child implements Test,Test2{
//
//   @override
//   // TODO: implement a
//   String get a => throw UnimplementedError();
//
//   @override
//   // TODO: implement b
//   String get b => throw UnimplementedError();
//    AChild(this.A);
//
// }
