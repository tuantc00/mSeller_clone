import 'package:collection/collection.dart';
import 'package:mseller/Models/promotion_model.dart';

enum DurationType {
  day,
  month,
  year;

  static DurationType? fromString(String? value) {
    if (value == null) return null;
    return DurationType.values.firstWhereOrNull(
      (type) => type.toString() == value.toLowerCase(),
    );
  }

  String toDisplayString() {
    switch (this) {
      case DurationType.day:
        return 'ngày';
      case DurationType.month:
        return 'tháng';
      case DurationType.year:
        return 'năm';
      default:
        return '';
    }
  }
}

class Package {
  final String? name;
  final int duration;
  final DurationType durationType;
  final int price;
  final bool isPopular;
  final Promotion? promotion;

  Package({
    this.name,
    required this.duration,
    required this.durationType,
    required this.price,
    this.isPopular = false,
    this.promotion,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      name: json['name'] as String?,
      duration: json['duration'] as int? ?? 0,
      durationType: DurationType.fromString(json['durationType'] as String?) ??
          DurationType.month,
      price: json['price'] as int? ?? 0,
      isPopular: json['isPopular'] as bool? ?? false,
      promotion: Promotion.fromJson(json['promotion'] as Map<String, dynamic>?),
    );
  }

  @override
  String toString() {
    return 'Package(name: $name, duration: $duration, durationType: $durationType, '
        'price: $price, isPopular: $isPopular, promotion: $promotion)';
  }
}
