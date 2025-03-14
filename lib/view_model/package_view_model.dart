import 'package:flutter/material.dart';

import '../datas/package_data.dart';
import '../model/package_model.dart';

class PackageViewModel with ChangeNotifier {
  List<Package> _packages = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Package> get packages => _packages;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchPackage() async {
    _isLoading = true;
    notifyListeners();
    try {
      await Future.delayed(Duration(milliseconds: 500));
      _packages = createMockPackageList();
      _packages = sortPackages(_packages);
    } catch (e) {
      _errorMessage = "Error fetching data: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Package> sortPackages(List<Package> packages) {
    packages.sort((a, b) {
      if (a.promotion != null && b.promotion == null) return -1;
      if (a.promotion == null && b.promotion != null) return 1;

      if (a.isPopular && !b.isPopular) return -1;
      if (!a.isPopular && b.isPopular) return 1;

      return 0;
    });
    return packages;
  }

  // String getPackageTag(Package package) {
  //   if (package.promotion != null) return 'Khuyến mãi';
  //   if (package.isPopular) return 'Phổ biến';
  //   return '';
  // }

  bool showBorder(Package package) {
    return package.promotion != null || package.isPopular;
  }

  String calculateSavings(Package package) {
    if (package.promotion == null || package.promotion!.price == null)
      return '';

    final originalPrice = package.price;
    final discountedPrice = package.promotion!.price!;
    final savings =
        (1 - (originalPrice - discountedPrice) / originalPrice) * 100;
    return 'Tiết kiệm ${savings.toStringAsFixed(0)}%';
  }

  String promotionTag(Package package) {
    if (package.promotion?.durationType != null) {
      return 'Tặng thêm: ${package.promotion!.duration} ${package.promotion!.durationType!.toDisplayString()}';
    }
    return '';
  }
// String getFormattedDuration(Package package) {
//   final duration = package.duration;
//   final durationType = package.durationType;
//
//   switch (durationType) {
//     case DurationType.day:
//       return '$duration ngày';
//     case DurationType.month:
//       final months = duration ~/ 30;
//       return '$months tháng';
//     case DurationType.year:
//       final years = duration ~/ 365;
//       return '$years năm';
//     default:
//       return '';
//   }
// }
}
