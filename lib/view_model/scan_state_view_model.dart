// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:mseller/Models/button_camera_scan_model.dart';
// import 'package:mseller/Models/product_model.dart';
//
// class BarcodeScanViewModel extends ChangeNotifier {
//
//   // final List<Map<String, dynamic>> _products = [
//   //   {
//   //     "name": "Product name 1",
//   //     "price": 10000,
//   //     "quantity": 2,
//   //     "barcode": "12345"
//   //   },
//   //   {
//   //     "name": "Product name 2",
//   //     "price": 10000,
//   //     "quantity": 2,
//   //     "barcode": "23456"
//   //   },
//   //   {
//   //     "name": "Product name 3",
//   //     "price": 10000,
//   //     "quantity": 2,
//   //     "barcode": "34567"
//   //   },
//   // ];
//
//   // final List<ButtonCameraScanModel> buttons = [
//   //   ButtonCameraScanModel(Icons.add_circle_outline, ActionButton.add, false),
//   //   ButtonCameraScanModel(Icons.remove_circle_outline, ActionButton.subtract, false),
//   //   ButtonCameraScanModel(Icons.refresh_outlined, ActionButton.replace, false),
//   //   ButtonCameraScanModel(Icons.delete_outline_rounded, ActionButton.delete, true),
//   // ];
//
//   final List<Product> products =[
//     Product(name: '000000000000000000000', price: 120000, barcode: '',quantity: 120 ,img: SvgPicture.asset('assets/product_card')),
//     Product(name: '111111111111', price: 22222222, barcode: '',quantity: 120 ,img: SvgPicture.asset('assets/product_card')),
//     Product(name: '222222222222', price: 33333, barcode: '',quantity: 120 ,img: SvgPicture.asset('assets/product_card')),
//   ];
//
//   ActionButton ?actionButton;
//   ScanMode _scanMode= ScanMode.combine;
//   ActionButton _selectedAction = ActionButton.add ;
//   int _counter = 1;
//
//
//   List<Product> get products =>_product;
//   //List<Map<String, dynamic>> get products => _products;
//   ScanMode get scanMode => _scanMode;
//   ActionButton get selectedAction => _selectedAction;
//   int get counter => _counter;
//
//
//   double get totalPrice {
//     return _products.fold(
//         0, (sum, product) => sum + (product["price"] * product["quantity"]));
//   }
//
//
//   void setScanMode(ScanMode mode) {
//     _scanMode = mode;
//     notifyListeners();
//   }
//
//
//   void setSelectedAction(ActionButton action) {
//     _selectedAction = action;
//     notifyListeners();
//   }
//
//
//   void setCounter(int value) {
//     if (value >= 1) {
//       _counter = value;
//       notifyListeners();
//     }
//   }
//
//
//   void handleBarcodeDetected(String barcode, int counter, ActionButton action) {
//     bool success = false;
//
//     if (_scanMode == ScanMode.combine) {
//       final existingIndex = _products.indexWhere((p) => p["barcode"] == barcode);
//       // If product already exists
//       if (existingIndex != -1) {
//         if (action==ActionButton.add) {
//           _products[existingIndex]["quantity"] += counter;
//           success = true;
//         } else if (action == ActionButton.subtract) {
//           int newQuantity = _products[existingIndex]["quantity"] - counter;
//           if (newQuantity <= 0) {
//             _products.removeAt(existingIndex);
//           } else {
//             _products[existingIndex]["quantity"] = newQuantity;
//           }
//           success = true;
//         } else if (action == ActionButton.replace) {
//           _products[existingIndex]["quantity"] = counter;
//           success = true;
//         } else if (action == ActionButton.delete) {
//           _products.removeAt(existingIndex);
//           success = true;
//         } else {
//
//           success = false;
//         }
//       }
//       // If product doesn't exist yet
//       else {
//         if (action == ActionButton.add || action == ActionButton.replace || action == null) {
//           _products.add({
//             "name": barcode,
//             "price": 10000,
//             "quantity": counter,
//             "barcode": barcode,
//           });
//           success = true;
//         } else if (action == ActionButton.delete || action == ActionButton.subtract) {
//
//           success = false;
//         } else {
//
//           success = false;
//         }
//       }
//     }
//     else if (_scanMode == ScanMode.split) {
//       if (action == ActionButton.add || action ==ActionButton.replace || action == null) {
//         _products.add({
//           "name": barcode,
//           "price": 10000,
//           "quantity": counter,
//           "barcode": barcode,
//         });
//         success = true;
//       } else if (action == ActionButton.delete || action == ActionButton.subtract) {
//         // In Split mode, delete and subtract don't make sense for new scans
//         success = false;
//       } else {
//         success = false;
//       }
//     } else {
//       success = false;
//     }
//
//     notifyListeners();
//
//     if (success) {
//       _showSnackBar('Quét thành công');
//     } else {
//       _showSnackBar('Quét thất bại');
//     }
//   }
//
//
//   // void updateProductQuantity(String barcode, int delta) {
//   //   final index = _products.indexWhere((p) => p["barcode"] == barcode);
//   //   if (index != -1) {
//   //     int newQuantity = _products[index]["quantity"] + delta;
//   //       //hãy sửa lại logic khi tăng hoặc giảm số lượng thì giảm đúng số product được nhấn chứ không phải phần tử đầu
//   //     if (newQuantity <= 0) {
//   //       _products.removeAt(index);
//   //     } else {
//   //       _products[index]["quantity"] = newQuantity;
//   //     }
//   //     notifyListeners();
//   //   }
//   // }
//   void updateProductQuantity(int index, int delta) {
//     if (index >= 0 && index < _products.length) {
//       int newQuantity = _products[index]["quantity"] + delta;
//       if (newQuantity <= 0) {
//         _products.removeAt(index);
//       } else {
//         _products[index]["quantity"] = newQuantity;
//       }
//       notifyListeners();
//     }
//   }
//
//
//
//   void _showSnackBar(String message) {
//   }
//
//   void reset() {
//     _scanMode = ScanMode.combine;
//     _selectedAction = ActionButton.add;
//     _counter = 1;
//     notifyListeners();
//   }
// }
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../model/button_camera_scan_model.dart';
import '../model/product_model.dart';
import '../widgets/style_toast_card.dart';

class BarcodeScanViewModel extends ChangeNotifier {
  final List<ButtonCameraScanModel> buttons = [
    ButtonCameraScanModel(Icons.add_circle_outline, ActionButton.add, false),
    ButtonCameraScanModel(
        Icons.remove_circle_outline, ActionButton.subtract, false),
    ButtonCameraScanModel(Icons.refresh_outlined, ActionButton.replace, false),
    ButtonCameraScanModel(
        Icons.delete_outline_rounded, ActionButton.delete, true),
  ];

  final List<Product> _products = [
    Product(
      name: '000000000000000000000',
      price: 120000,
      barcode: '',
      quantity: 120,
      img: SvgPicture.asset('assets/product_cart.svg'),
    ),
  ];

  ScanMode _scanMode = ScanMode.combine;
  ActionButton _selectedAction = ActionButton.add;
  int _counter = 1;

  List<Product> get products => _products;
  ScanMode get scanMode => _scanMode;
  ActionButton get selectedAction => _selectedAction;
  int get counter => _counter;

  MobileScannerController? _cameraController;
  void setCameraController(MobileScannerController controller) {
    _cameraController = controller;
  }

  void stopCamera() {
    _cameraController?.stop();
  }

  void startCamera() {
    _cameraController?.start();
  }

  double get totalPrice {
    return _products.fold(
        0, (sum, product) => sum + (product.price * product.quantity));
  }

  void setScanMode(ScanMode mode) {
    _scanMode = mode;
    notifyListeners();
  }

  void setSelectedAction(ActionButton action) {
    _selectedAction = action;
    notifyListeners();
  }

  void setCounter(int value) {
    if (value >= 1) {
      _counter = value;
      notifyListeners();
    }
  }

  void _showToast(BuildContext context, String message, String actionText,
      VoidCallback onActionPressed) {
    DelightToastBar(
      builder: (context) => StyleToastCard(
        Colors.white,
        null,
        message,
        actionText,
        () {
          onActionPressed();
          DelightToastBar(
            builder: (context) => StyleToastCard(
              Colors.red,
              null,
              'Đã hoàn tác',
              '',
              () {},
            ),
            position: DelightSnackbarPosition.top,
            autoDismiss: true,
            snackbarDuration: const Duration(milliseconds: 500),
          ).show(context);
        },
      ),
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      snackbarDuration: const Duration(seconds: 2),
    ).show(context);
  }

  void handleBarcodeDetected(
      BuildContext context, String barcode, int counter, ActionButton action) {
    List<Product> previousProducts = List.from(_products);

    bool success = false;
    String message = '';

    if (_scanMode == ScanMode.combine) {
      final existIndex = _products.indexWhere((p) => p.barcode == barcode);
      if (existIndex != -1) {
        switch (action) {
          case ActionButton.add:
            _products[existIndex].quantity += counter;
            success = true;
            message = 'Đã thêm $counter sản phẩm';
            break;
          case ActionButton.subtract:
            int newQuantity = _products[existIndex].quantity - counter;
            if (newQuantity <= 0) {
              _products.removeAt(existIndex);
              message = 'Đã xóa sản phẩm';
            } else {
              _products[existIndex].quantity = newQuantity;
              message = 'Đã bớt $counter sản phẩm';
            }
            success = true;
            break;
          case ActionButton.replace:
            _products[existIndex].quantity = counter;
            success = true;
            message = 'Đã sửa $counter sản phẩm';
            break;
          case ActionButton.delete:
            _products.removeAt(existIndex);
            success = true;
            message = 'Đã xóa sản phẩm';
            break;
          default:
            message = 'Hành động không hợp lệ';
        }
      } else {
        if (action == ActionButton.add || action == ActionButton.replace) {
          _products.add(Product(
            name: barcode,
            price: 10000,
            quantity: counter,
            barcode: barcode,
            img: SvgPicture.asset('assets/product_cart.svg'),
          ));
          success = true;
          message = 'Đã thêm $counter sản phẩm';
        } else {
          message = 'Sản phẩm không tồn tại để thực hiện hành động này';
        }
      }
    } else if (_scanMode == ScanMode.split) {
      if (action == ActionButton.add || action == ActionButton.replace) {
        _products.add(Product(
          name: barcode,
          price: 10000,
          quantity: counter,
          barcode: barcode,
          img: SvgPicture.asset('assets/product_cart.svg'),
        ));
        success = true;
        message = 'Đã thêm $counter sản phẩm';
      } else {
        message = 'Không thể thực hiện hành động này trong chế độ tách';
      }
    }
    notifyListeners();
    if (success) {
      _showToast(context, message, 'Hoàn tác', () {
        _products.clear();
        _products.addAll(previousProducts);
        notifyListeners();
      });
    } else {
      _showToast(context, 'Lỗi', '', () {});
    }
  }

  void updateProductQuantity(int index, int delta) {
    if (index >= 0 && index < _products.length) {
      int newQuantity = _products[index].quantity + delta;
      if (newQuantity <= 0) {
        _products.removeAt(index);
      } else {
        _products[index].quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  void reset() {
    _scanMode = ScanMode.combine;
    _selectedAction = ActionButton.add;
    _counter = 1;
    notifyListeners();
  }
}
