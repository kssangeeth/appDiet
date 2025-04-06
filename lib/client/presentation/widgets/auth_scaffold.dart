import 'package:app_diett/client/core/constants/colors.dart';
import 'package:app_diett/client/core/constants/images.dart';
import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;

  const AuthScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            TImages.ellipse,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 90),
              Expanded(
                child: child,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
