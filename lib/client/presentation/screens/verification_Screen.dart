import 'package:app_diett/client/core/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:app_diett/client/core/constants/colors.dart';
import 'package:app_diett/client/presentation/widgets/otp_textfield.dart';
import 'package:app_diett/client/presentation/widgets/auth_scaffold.dart';
import 'package:app_diett/client/presentation/widgets/signin_button.dart';
// Assuming BackButtonCircle is here

class VerificationScreen extends StatefulWidget {
  final String email;

  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleChange(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _submitCode() {
    final code = _controllers.map((e) => e.text).join();
    if (code.length == 4) {
      print("Verification code entered: $code");
      // TODO: Add your verification logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const BackButtonCircle(),
            const SizedBox(height: 50),
            _buildHeader(),
            const SizedBox(height: 40),

            /// OTP TextFields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return OTPTextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  onChanged: (value) => _handleChange(index, value),
                );
              }),
            ),

            const Spacer(),

            /// Submit Button
            SocialSignInButton(
              text: TTexts.verify,
              onPressed: _submitCode,
              backgroundColor: TColors.primary,
              textColor: TColors.primaryBackground,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TTexts.forgotpassword,
          style: TextStyle(
            color: TColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          TTexts.entertheverificationcode,
          style: TextStyle(
            color: TColors.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          widget.email,
          style: TextStyle(
            color: TColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
