import 'package:flutter/material.dart';
import 'package:app_diett/client/core/constants/colors.dart';

class CustomTextLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final TextDecoration? decoration;
  final TextAlign? align;

  const CustomTextLink({
    super.key,
    required this.label,
    required this.onTap,
    this.fontSize = 14,
    this.color,
    this.fontWeight = FontWeight.bold,
    this.decoration,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        textAlign: align,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? TColors.primary,
          decoration: decoration,
        ),
      ),
    );
  }
}
