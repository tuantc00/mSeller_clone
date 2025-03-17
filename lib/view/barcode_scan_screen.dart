import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mseller/widgets/custome_dialog.dart';
import 'package:provider/provider.dart';

import '../model/button_camera_scan_model.dart';
import '../view_model/scan_state_view_model.dart';
import '../widgets/camera_scan_field.dart';
import '../widgets/number_adjust.dart';
import '../widgets/row_button.dart';
import '../widgets/style_toast_card.dart';

class BarcodeScanScreen extends StatelessWidget {
  const BarcodeScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BarcodeScanViewModel(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Quét thêm sản phẩm',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.check)),
            ),
          ],
        ),
        body: const BodyBuild(),
      ),
    );
  }
}

class BodyBuild extends StatelessWidget {
  const BodyBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BarcodeScanViewModel>(context);
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Chế độ quét: ${_getActionText(viewModel.selectedAction)} ${viewModel.counter} sản phẩm',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () => viewModel.reset(),
                        child: const Text(
                          'Làm mới',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            color: Colors.teal,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BuildNumberAdjust(),
                      BuildRowButtons(),
                      IconButton(
                          onPressed: () {
                            // Lấy state của CameraScanField từ key
                            final cameraScanField =
                                Provider.of<BarcodeScanViewModel>(context,
                                    listen: false);
                            // Dừng camera

                            cameraScanField.stopCamera();

                            showDialog(
                                    context: context,
                                    builder: (context) => const CustomeDialog())
                                .then((_) {
                              // Khởi động lại camera khi dialog đóng
                              cameraScanField.startCamera();
                            });
                          },
                          icon: const Icon(
                            Icons.help_outline_outlined,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CameraScanField(
                  onBarcodeDetected: (barcode, counter, action) {
                    viewModel.handleBarcodeDetected(
                        context, barcode, counter, action!);
                  },
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Sản phẩm đã quét ',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Stack(
            children: [
              SizedBox(
                height: 450,
                child: Container(
                  color: const Color.fromARGB(1, 208, 216, 221),
                  child: ListView.builder(
                    itemCount: viewModel.products.length,
                    itemBuilder: (context, index) {
                      final product = viewModel.products[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Container(
                          width: 343,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 0.5, color: Colors.grey),
                            ),
                          ),
                          child: ListTile(
                            leading: product.img,
                            title: Text(
                              product.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            subtitle: Text(
                              formatter.format(product.price),
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: 36,
                              width: 111,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 32,
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () => viewModel
                                          .updateProductQuantity(index, -1),
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 36,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Center(
                                        child: IntrinsicWidth(
                                          child: Text(
                                            '${product.quantity}',
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 32,
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () => viewModel
                                          .updateProductQuantity(index, 1),
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 60,
                    child: Container(
                      width: 343,
                      height: 69,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/product_cart.svg'),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      formatter.format(viewModel.totalPrice),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: 'Bạn đã thêm ',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${viewModel.products.length}',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.teal),
                                          ),
                                          TextSpan(text: ' SP/DV'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            child: ElevatedButton(
                              onPressed: () {
                                DelightToastBar(
                                  builder: (context) {
                                    return StyleToastCard(
                                      Colors.white,
                                      null,
                                      '${viewModel.totalPrice}',
                                      'Tổng tiền',
                                      () {},
                                    );
                                  },
                                  position: DelightSnackbarPosition.bottom,
                                  autoDismiss: true,
                                  snackbarDuration: Duration(seconds: 4),
                                ).show(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Tính tiền',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getActionText(ActionButton action) {
    switch (action) {
      case ActionButton.add:
        return 'Thêm';
      case ActionButton.subtract:
        return 'Bớt';
      case ActionButton.replace:
        return 'Sửa';
      case ActionButton.delete:
        return 'Xóa';
      default:
        return 'Thêm';
    }
  }
}
