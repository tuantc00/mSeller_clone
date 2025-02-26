import 'package:intl/intl.dart';

import '../Models/branches_model.dart';

Branch createMockBranch() {
  return Branch(
    name: "Cơm rang",
    avatar: "assets/shop_logo.svg",
    status: true,
    lastExtendDate: DateTime.now(),
    expiredDate: DateTime.now().add(Duration(days: 30)),
  );
}

int calculateRemainingDays(DateTime expiredDate) {
  final now = DateTime.now();
  final difference = expiredDate.difference(now).inDays;
  return difference;
}
