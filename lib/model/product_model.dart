import 'package:flutter_svg/flutter_svg.dart';

class Product {
  final SvgPicture img;
  final String name;
  final double price;
  final String barcode;
  int quantity;

  Product({
    required this.img,
    required this.name,
    required this.price,
    required this.barcode,
    required this.quantity,
  });
}
