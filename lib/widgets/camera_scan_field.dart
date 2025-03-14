import 'dart:async';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mseller/widgets/style_toast_card.dart';

import 'package:provider/provider.dart';

import '../model/button_camera_scan_model.dart';
import '../view_model/scan_state_view_model.dart';

class CameraScanField extends StatefulWidget {
  final Function(String, int, ActionButton?) onBarcodeDetected;

  const CameraScanField({super.key, required this.onBarcodeDetected});

  @override
  State<CameraScanField> createState() => _CameraScanFieldState();
}

class _CameraScanFieldState extends State<CameraScanField>
    with WidgetsBindingObserver {
  bool isScanning = true;
  MobileScannerController controller = MobileScannerController(
    formats: [BarcodeFormat.all],
    facing: CameraFacing.back,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(const Duration(milliseconds: 500), () {
      controller.start();
      setState(() => isScanning = true);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.start();
      setState(() => isScanning = true);
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      controller.stop();
      setState(() => isScanning = false);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void onBarcodeDetected(BarcodeCapture capture) {
    if (!isScanning) return;

    final viewModel = Provider.of<BarcodeScanViewModel>(context, listen: false);
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      String? newBarcode = barcode.rawValue;
      if (newBarcode != null) {
        setState(() {
          isScanning = false;
          widget.onBarcodeDetected(
              newBarcode, viewModel.counter, viewModel.selectedAction);
          Timer(const Duration(seconds: 2), () {
            if (mounted) setState(() => isScanning = true);
          });
        });
      } else {
        DelightToastBar(
          builder: (context) {
            return StyleToastCard(
              Colors.redAccent.shade100,
              null,
              'Không thể đọc được mã vạch',
              '',
              () {},
            );
          },
          position: DelightSnackbarPosition.bottom,
          autoDismiss: true,
          snackbarDuration: const Duration(seconds: 1),
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BarcodeScanViewModel>(context);
    final screenSize = MediaQuery.of(context).size;
    final scannerWidth = screenSize.width * 0.95;
    final scannerHeight = screenSize.width * 0.95 * 0.5;

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(13.0)),
          child: SizedBox(
            width: 350,
            height: 170,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: MobileScanner(
                controller: controller,
                onDetect: onBarcodeDetected,
                scanWindow: Rect.fromLTWH(
                  (scannerWidth - scannerWidth * 0.8) / 2,
                  (scannerHeight - scannerHeight * 0.6) / 2,
                  scannerWidth * 0.8,
                  scannerHeight * 0.6,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 16),
          child: Container(
            width: 104,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.5),
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownMenu<ScanMode>(
              trailingIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 20,
              ),
              initialSelection: viewModel.scanMode,
              onSelected: (ScanMode? newMode) {
                if (newMode != null) {
                  viewModel.setScanMode(newMode);
                }
              },
              dropdownMenuEntries: const [
                DropdownMenuEntry(
                  value: ScanMode.combine,
                  label: 'Gộp',
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                ),
                DropdownMenuEntry(
                  value: ScanMode.split,
                  label: 'Tách',
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                ),
              ],
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400),
              menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.black12),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
              selectedTrailingIcon:
                  const Icon(Icons.keyboard_arrow_up, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
