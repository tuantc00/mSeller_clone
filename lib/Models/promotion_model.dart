import 'package:mseller/Models/package_model.dart';

class Promotion {
  final int? price;
  final int? duration;
  final DurationType? durationType;

  Promotion({
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
