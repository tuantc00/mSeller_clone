// class Company {
//   final String id;
//   final String? companyname;
//
//   Company({required this.id, this.companyname});
//
//   factory Company.fromJson(Map<String, dynamic>? json) {
//     if (json == null) {
//       throw const FormatException('Null JSON provided for Company');
//     }
//     if (!json.containsKey('id')) {
//       throw const FormatException('JSON is missing required key: id for Company');
//     }
//     return Company(
//       id: json['id'] as String,
//       companyname: json['companyname'] as String?,
//     );
//   }
//
//   @override
//   String toString() {
//     return 'Company{id: $id, companyname: $companyname}';
//   }
// }

class UserModel {
  final String? id;
  final String phoneNumber;
  //final String password;
  final String? fullName;
  final String? avatar;
 // final Company? company;
  final String? bankAccountNumber;
  final String? bankAccountName;

  UserModel({
    this.id,
    required this.phoneNumber,
    //required this.password,
    this.fullName,
    this.avatar,
   // this.company,
    this.bankAccountNumber,
    this.bankAccountName,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException('Null JSON provided');
    }
    if (!json.containsKey('phoneNumber')  ) {
      throw const FormatException(
          'JSON is missing required keys: phoneNumber');
    }

    return UserModel(
      id: json['id'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      //password: json['password'] as String,
      fullName: json['fullName'] as String?,
      avatar: json['avatar'] as String?,
      //company: Company.fromJson(json['company'] as Map<String, dynamic>?),
      bankAccountNumber: json['bankAccountNumber'] as String?,
      bankAccountName: json['bankAccountName'] as String?,
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, phoneNumber: $phoneNumber '
        'fullName: $fullName, avatar: $avatar, '
        'bankAccountNumber: $bankAccountNumber, bankAccountName: $bankAccountName}';
  }
}