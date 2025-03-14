import 'package:mseller/datas/promotion_data.dart';

import '../model/package_model.dart';

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
      name: "Popular Package 10000000",
      duration: 12,
      durationType: DurationType.month,
      price: 5000000,
      isPopular: true,
    ),
    Package(
      name: "Premium Package 200000",
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
      price: 500000000,
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
