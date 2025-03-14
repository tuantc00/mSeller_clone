import 'package:flutter/material.dart';

class StyleInputField extends StatelessWidget {
  const StyleInputField({
    super.key,
    required this.onPressed,
    // this.child,
    required this.hintText,
    required this.labelName,
    this.validator, // Thêm validator
    this.controller, // Thêm controller
  });

  final void Function() onPressed;
  //final Widget child;
  final String hintText;
  final String labelName;
  final String? Function(String?)? validator; // Thêm validator
  final TextEditingController? controller; // Thêm controller

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Sử dụng controller
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        labelText: labelName,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      validator: validator, // Sử dụng validator
    );
  }
}
