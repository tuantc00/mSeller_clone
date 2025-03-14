class Branch {
  final String? name;
  final String? avatar;
  final bool status;
  final DateTime? lastExtendDate;
  final DateTime? expiredDate;

  Branch({
    this.name,
    this.avatar,
    this.status = false,
    this.lastExtendDate,
    this.expiredDate,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      status: json['status'] as bool? ?? false,
      lastExtendDate: json['lastExtendDate'] != null
          ? DateTime.tryParse(json['lastExtendDate'].toString())
          : null,
      expiredDate: json['expiredDate'] != null
          ? DateTime.tryParse(json['expiredDate'].toString())
          : null,
    );
  }

  @override
  String toString() {
    return 'Branch(name: $name, avatar: $avatar, status: $status, lastExtendDate: $lastExtendDate, expiredDate: $expiredDate)';
  }
}
