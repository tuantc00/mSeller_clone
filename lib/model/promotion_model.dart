import 'package:mseller/model/package_model.dart';

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

class Promotion {
  final PromotionType? promotionType;
  final int? price;
  final int? duration;
  final DurationType? durationType;

  Promotion({
    this.promotionType,
    this.price,
    this.duration,
    this.durationType,
  });

  factory Promotion.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Promotion();

    return Promotion(
      price: json['price'] as int?,
      duration: json['duration'] as int?,
      durationType: DurationType.fromString(json['durationType'] as String?),
    );
  }

  @override
  String toString() {
    return 'Promotion(price: $price, duration: $duration, durationType: $durationType)';
  }
}
