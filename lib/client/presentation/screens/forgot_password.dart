import 'package:app_diett/client/core/constants/colors.dart';
import 'package:app_diett/client/core/constants/images.dart';
import 'package:app_diett/client/core/constants/texts.dart';
import 'package:app_diett/client/presentation/screens/verification_Screen.dart';
import 'package:app_diett/client/presentation/widgets/custom_text_field.dart';
import 'package:app_diett/client/presentation/widgets/otp_textfield.dart';
import 'package:app_diett/client/presentation/widgets/signin_button.dart';
import 'package:app_diett/client/presentation/widgets/auth_scaffold.dart';

import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _sendVerification() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VerificationScreen(email: _emailController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            BackButtonCircle(),
            SizedBox(height: 40),

            /// Title and Description
            Text(
              TTexts.forgotpassword,
              style: TextStyle(
                color: TColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              TTexts.sendcodeprompt,
              style: TextStyle(
                color: TColors.textSecondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 140),

            /// Email Input
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    label: TTexts.email,
                    controller: _emailController,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return TTexts.enteryourmobilenumber;
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return TTexts.entervalidemobilenumber;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 70),

                  /// Submit Button
                  SocialSignInButton(
                    text: TTexts.next,
                    onPressed: _sendVerification,
                    backgroundColor: TColors.primary,
                    textColor: TColors.primaryBackground,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
