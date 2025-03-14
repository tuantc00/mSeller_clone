import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../model/package_model.dart';
import '../view_model/package_view_model.dart';

class PackageCard extends StatelessWidget {
  final Package package;
  final PackageViewModel packViewModel;

  const PackageCard({super.key, required this.package, required this.packViewModel});

  @override
  Widget build(BuildContext context) {
    final tag = package.getPackageTag();
    final showBorder = packViewModel.showBorder(package);
    final promotionTagPrice = packViewModel.calculateSavings(package);
    final promotionTagDuration = packViewModel.promotionTag(package);
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    int discountedPrice = 0;
    if (promotionTagPrice.isNotEmpty) {
      discountedPrice = package.price - (package.promotion?.price ?? 0);
    }

    return Container(
      height: 105,
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
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              '${package.name}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Thời gian sử dụng: ${package.duration} ${package.durationType.toDisplayString()}',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Wrap(
                            spacing: 8,
                            children: [
                              if (promotionTagPrice.isNotEmpty)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 37, 169, 135),
                                    borderRadius: BorderRadius.circular(5),
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
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      width: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (tag.isNotEmpty) ...[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: package.promotion != null
                                    ? Color.fromARGB(255, 37, 169, 135)
                                    : Colors.white,
                                border: Border.all(
                                  color: Color.fromARGB(255, 37, 169, 135),
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              constraints: BoxConstraints(minWidth: 60),
                              child: Text(
                                tag,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: package.promotion != null
                                      ? Colors.white
                                      : Color.fromARGB(255, 37, 169, 135),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                          if (promotionTagPrice.isNotEmpty)
                            Column(
                              children: [
                                Text(
                                  '${currencyFormat.format(package.price)}',
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  currencyFormat.format(discountedPrice),
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              children: [
                                Text(
                                  currencyFormat.format(package.price),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                        ],
                      ),
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
