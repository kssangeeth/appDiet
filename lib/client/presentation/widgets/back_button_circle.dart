import 'package:app_diett/client/core/constants/colors.dart';
import 'package:flutter/material.dart';

class BackButtonCircle extends StatelessWidget {
  final VoidCallback? onTap;

  const BackButtonCircle({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      alignment: Alignment.centerLeft,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: TColors.primary,
        child: IconButton(
          onPressed: onTap ?? () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: TColors.primaryBackground,
          ),
        ),
      ),
    );
  }
}
