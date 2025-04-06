import 'package:app_diett/client/core/constants/colors.dart';
import 'package:app_diett/client/core/constants/images.dart';
import 'package:app_diett/client/core/constants/texts.dart';
import 'package:app_diett/client/presentation/screens/login_screen.dart';

import 'package:app_diett/client/presentation/widgets/custom_text_field.dart';
import 'package:app_diett/client/presentation/widgets/auth_scaffold.dart';
import 'package:app_diett/client/presentation/widgets/custom_text_link.dart';
import 'package:app_diett/client/presentation/widgets/otp_textfield.dart';
import 'package:app_diett/client/presentation/widgets/signin_button.dart';

import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            BackButtonCircle(),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: TTexts.signupn,
                    style: TextStyle(
                      color: TColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  TextSpan(
                    text: TTexts.createaccount,
                    style: TextStyle(
                      color: TColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            /// Name
            CustomTextField(
              label: TTexts.name,
              controller: _nameController,
              prefixIcon: Icons.person_outline_outlined,
            ),

            /// Mobile Number
            CustomTextField(
              label: TTexts.mobilenumber,
              controller: _mobileController,
              prefixIcon: Icons.phone_iphone_outlined,
              keyboardType: TextInputType.phone,
            ),

            /// Email
            CustomTextField(
              label: TTexts.email,
              controller: _emailController,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            /// Password
            CustomTextField(
              label: TTexts.password,
              controller: _passwordController,
              obscureText: _obscurePassword,
              prefixIcon: Icons.lock_outlined,
              suffixIcon: _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              onSuffixTap: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            const SizedBox(height: 10),

            /// Terms & Conditions
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  TTexts.agree,
                  style: TextStyle(fontSize: 12),
                ),
                CustomTextLink(
                  label: TTexts.terms,
                  fontSize: 12,
                  onTap: () {},
                )
              ],
            ),
            const SizedBox(height: 10),

            /// Sign Up Button
            SocialSignInButton(
              text: TTexts.signup,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              backgroundColor: TColors.primary,
              textColor: TColors.primaryBackground,
            ),

            const SizedBox(height: 18),

            /// OR Divider
            Row(
              children: [
                Expanded(child: Divider(thickness: 1, color: TColors.black)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    TTexts.or,
                    style: TextStyle(
                      color: TColors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(child: Divider(thickness: 1, color: TColors.black)),
              ],
            ),
            const SizedBox(height: 20),

            /// Google Sign In
            SocialSignInButton(
              text: TTexts.loginwithgoogle,
              onPressed: () {},
              icon: Image.asset(TImages.googlecon, width: 16, height: 16),
            ),
            const SizedBox(height: 20),

            /// Facebook Sign In
            SocialSignInButton(
              text: TTexts.loginwithfacebook,
              onPressed: () {},
              icon: Image.asset(TImages.facebookcon, width: 16, height: 16),
            ),
            const SizedBox(height: 20),

            /// Already have account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  TTexts.alreadyhave,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                CustomTextLink(
                  label: TTexts.signin,
                  fontSize: 14,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
