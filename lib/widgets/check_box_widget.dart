import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final Color borderColor;
  const CustomCheckBox({super.key, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: borderColor),
      ),
      child: Icon(Icons.check, color: borderColor, size: 16),
    );
  }
}
