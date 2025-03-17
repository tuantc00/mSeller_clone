import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../model/button_camera_scan_model.dart';
import '../view_model/scan_state_view_model.dart';

class BuildRowButtons extends StatelessWidget {
  BuildRowButtons({super.key});

  final List<ButtonCameraScanModel> buttons = [
    ButtonCameraScanModel(Icons.add_circle_outline, ActionButton.add, false),
    ButtonCameraScanModel(
        Icons.remove_circle_outline, ActionButton.subtract, false),
    ButtonCameraScanModel(Icons.refresh_outlined, ActionButton.replace, false),
    ButtonCameraScanModel(
        Icons.delete_outline_rounded, ActionButton.delete, true),
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BarcodeScanViewModel>(context);
    final selectedIndex = buttons.indexWhere(
        (button) => button.actionButton == viewModel.selectedAction);

    return Container(
      width: 160,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5, color: Colors.grey),
      ),
      child: Row(
        children: List.generate(buttons.length * 2 - 1, (index) {
          if (index.isOdd) {
            return VerticalDivider(
              color: Colors.grey,
              thickness: 0.5,
              width: 1,
              indent: 8,
              endIndent: 8,
            );
          } else {
            final buttonIndex = index ~/ 2;
            final button = buttons[buttonIndex];
            return Expanded(
              child: GestureDetector(
                onTap: () => viewModel.setSelectedAction(button.actionButton),
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedIndex == buttonIndex
                        ? Colors.greenAccent.shade100
                        : Colors.transparent,
                    border: Border.all(
                      color: selectedIndex == buttonIndex
                          ? Colors.greenAccent
                          : Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: _getBorderRadius(buttonIndex),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    button.icon,
                    color: selectedIndex == buttonIndex
                        ? Colors.greenAccent
                        : button.isDeleted == true
                            ? Colors.red
                            : Colors.grey,
                    size: 20,
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
    } else if (index == buttons.length - 1) {
      return BorderRadius.only(
          topRight: Radius.circular(10), bottomRight: Radius.circular(10));
    } else {
      return BorderRadius.zero;
    }
  }
}
