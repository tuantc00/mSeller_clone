import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum ActionButton {
  add,
  subtract,
  replace,
  delete,
}

enum ScanMode { combine, split }

class ButtonCameraScanModel {
  final IconData icon;
  final ActionButton actionButton;
  final bool? isDeleted;

  ButtonCameraScanModel(this.icon, this.actionButton, this.isDeleted);
}
