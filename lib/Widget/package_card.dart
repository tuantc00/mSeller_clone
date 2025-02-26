import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mseller/Models/package_model.dart';
import 'package:mseller/ViewModels/package_view_model.dart';

class PackageCard extends StatelessWidget {
  final Package package;
  final PackageViewModel packViewModel;

  PackageCard({required this.package, required this.packViewModel});

  @override
  Widget build(BuildContext context) {
    final tag = packViewModel.getPackageTag(package);
    final showBorder = packViewModel.showBorder(package);
    final promotionTagPrice = packViewModel.calculateSavings(package);
    final promotionTagDuration = packViewModel.promotionTag(package);
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    int discountedPrice = 0; //
    if (promotionTagPrice.isNotEmpty) {
      discountedPrice = package.price - (package.promotion?.price ?? 0);
    }

    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: showBorder ? 2 : 1,
          color: showBorder ? Colors.greenAccent : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 37, 169, 135),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16)),
              ),
              height: double.infinity,
              child: SvgPicture.asset('assets/logo_package.svg'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${package.name}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                            'Thời gian sử dụng: ${package.duration} ${package.durationType.toDisplayString()}',
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        if (promotionTagPrice.isNotEmpty)
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 37, 169, 135),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              promotionTagPrice,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        if (promotionTagDuration.isNotEmpty)
                          Container(
                            child: Text(
                              promotionTagDuration,
                              style: TextStyle(
                                color: Color.fromARGB(255, 37, 169, 135),
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border(left: BorderSide(color: Colors.black12, width: 1)),
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (tag.isNotEmpty)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: tag == 'Khuyến mãi'
                                  ? Color.fromARGB(255, 37, 169, 135)
                                  : Colors.white,
                              border: tag == 'Khuyến mãi'
                                  ? Border.all(
                                      color: Color.fromARGB(255, 37, 169, 135),
                                      width: 1,
                                    )
                                  : Border.all(
                                      color: Color.fromARGB(255, 37, 169, 135),
                                      width: 1),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            constraints: BoxConstraints(minWidth: 60),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: tag == 'Khuyến mãi'
                                    ? Colors.white
                                    : Color.fromARGB(255, 37, 169, 135),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 10),
                    if (promotionTagPrice.isNotEmpty)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${currencyFormat.format(package.price)}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${currencyFormat.format(discountedPrice)}',
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    if (promotionTagPrice.isEmpty)
                      Row(
                        children: [
                          Text(
                            '${currencyFormat.format(package.price)}',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
