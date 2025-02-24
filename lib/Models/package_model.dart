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
}

enum PromotionType {
  price,
  duration;

  static PromotionType fromString(String value) {
    return PromotionType.values.firstWhere(
      (type) => type.toString() == value.toLowerCase(),
      orElse: () => PromotionType.price,
    );
  }
}

class Package {
  final String? name;
  final int duration;
  final DurationType durationType;
  final int price;
  final bool isPopular;
  final Promotion? promotion;
  final PromotionType type;

  Package({
    this.name,
    required this.duration,
    required this.durationType,
    required this.price,
    this.isPopular = false,
    this.promotion,
    required this.type,
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
      type: PromotionType.fromString(json['type'] as String? ?? 'price'),
    );
  }

  @override
  String toString() {
    return 'Package(name: $name, duration: $duration, durationType: $durationType, '
        'price: $price, isPopular: $isPopular, promotion: $promotion, type: $type)';
  }
}
