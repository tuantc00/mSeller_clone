class UserModel{
  final String phone;
  final String token;

  UserModel({
   required this.phone,
   required this.token
});
  factory UserModel.fromJson(Map<String,dynamic> json)
  {
    return UserModel
      (phone: json['phone'], token: json['token']);
}
}