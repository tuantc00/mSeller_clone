import 'package:mseller/Data/promotion_data.dart';

import '../Models/package_model.dart';
import '../Models/promotion_model.dart';

List<Package> createMockPackageList() {
  return [
    Package(
      name: "Super Basic Package",
      duration: 12,
      durationType: DurationType.month,
      price: 2000000,
      isPopular: false,
      promotion: null,
    ),
    Package(
      name: "Standard Package",
      duration: 3,
      durationType: DurationType.month,
      price: 2500000,
      isPopular: true,
      promotion: createMockPromotionPrice(),
    ),
    Package(
      name: "Premium Package 1",
      duration: 12,
      durationType: DurationType.month,
      price: 5000000,
    ),
    Package(
      name: "Popular Package 1",
      duration: 12,
      durationType: DurationType.month,
      price: 5000000,
      isPopular: true,
    ),
    Package(
      name: "Premium Package 2",
      duration: 12,
      durationType: DurationType.month,
      price: 5000000,
      isPopular: false,
      promotion: createMockPromotionPrice(),
    ),
    Package(
      name: "Premium Package 3",
      duration: 12,
      durationType: DurationType.month,
      price: 5000000,
      isPopular: true,
      promotion: createMockPromotionDuratioDays(),
    ),
    Package(
      name: "Free Package ",
      duration: 12,
      durationType: DurationType.month,
      price: 5000000,
      isPopular: true,
      promotion: createMockPromotionDuratioDays(),
    ),
    Package(
      name: "Free Package Month ",
      duration: 12,
      durationType: DurationType.month,
      price: 5000000,
      isPopular: true,
      promotion: createMockPromotionDuratioMonths(),
    ),
  ];
}
