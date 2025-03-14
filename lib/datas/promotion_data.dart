import '../model/package_model.dart';
import '../model/promotion_model.dart';

Promotion createMockPromotionPrice() {
  return Promotion(
    price: 500000,
    promotionType: PromotionType.price,
  );
}

Promotion createMockPromotionDuratioDays() {
  return Promotion(
    promotionType: PromotionType.duration,
    duration: 30,
    durationType: DurationType.day,
  );
}

Promotion createMockPromotionDuratioMonths() {
  return Promotion(
    promotionType: PromotionType.duration,
    duration: 12,
    durationType: DurationType.month,
  );
}
