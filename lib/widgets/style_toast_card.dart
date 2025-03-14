import 'package:flutter/material.dart';

class StyleToastCard extends StatelessWidget {
  final Color? color;
  final Color? shadowColor;
  final String? textTile;
  final String? textButton;
  final Function()? onTap;

  const StyleToastCard(
      this.color, this.shadowColor, this.textTile, this.textButton, this.onTap,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.greenAccent.shade100,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(

                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset.zero,
                color: shadowColor ?? Colors.black.withOpacity(0.05))
          ]),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.teal),
                    const SizedBox(width: 5),
                    Text(
                      '$textTile',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(color: Colors.teal, width: 1, thickness: 0.5),
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: onTap,
                child: Text(
                  '$textButton',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.teal,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
