class BankModel {
  String nameBank;
  String bankNumber;
  String ownerBank;

  BankModel({
    required this.nameBank,
    required this.bankNumber,
    required this.ownerBank,
  });

  factory BankModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException('Null Json provided');
    }
    if (!json.containsKey('bankId') || !json.containsKey('owner')) {
      throw const FormatException(
          ' Json is missing required keys: phone, token or otp');
    }
    return BankModel(
        bankNumber: json['bankId'],
        ownerBank: json['owner'],
        nameBank: 'bankName');
  }

  @override
  String toString() {
    return 'BankModel{bankNumber: $bankNumber, ownerBank: $ownerBank}';
  }
}
