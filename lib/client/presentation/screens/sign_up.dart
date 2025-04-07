import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// Import your custom widgets and constants
import 'package:app_diett/client/core/constants/colors.dart';
import 'package:app_diett/client/core/constants/images.dart';
import 'package:app_diett/client/core/constants/texts.dart';

import 'package:app_diett/client/presentation/screens/home_screen.dart';
import 'package:app_diett/client/presentation/screens/login_screen.dart';
import 'package:app_diett/client/presentation/widgets/auth_scaffold.dart';
import 'package:app_diett/client/presentation/widgets/custom_text_field.dart';
import 'package:app_diett/client/presentation/widgets/custom_text_link.dart';
import 'package:app_diett/client/presentation/widgets/signin_button.dart';
import 'package:app_diett/client/presentation/widgets/otp_textfield.dart';

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
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = _nameController.text.trim();
    final mobile = _mobileController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || mobile.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all the fields')),
      );
      return;
    }

    final url = Uri.parse(
        'http://10.0.2.2:3000/api/auth/signup'); // Update to your actual endpoint

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'mobile_number': mobile,
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else if (response.statusCode == 409 ||
          (data['message']?.contains('exists') ?? false)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'User already exists')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Signup failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 10),
              BackButtonCircle(),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),

              /// Name
              CustomTextField(
                label: TTexts.name,
                controller: _nameController,
                prefixIcon: Icons.person_outline_outlined,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Please enter your name'
                    : null,
              ),

              /// Mobile Number
              CustomTextField(
                label: TTexts.mobilenumber,
                controller: _mobileController,
                prefixIcon: Icons.phone_iphone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Please enter your mobile number'
                    : null,
              ),

              /// Email
              CustomTextField(
                label: TTexts.email,
                controller: _emailController,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Please enter your email'
                    : null,
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
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Please enter your password'
                    : null,
              ),
              const SizedBox(height: 10),

              /// Terms & Conditions
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('I agree to the ', style: TextStyle(fontSize: 12)),
                  CustomTextLink(
                    label: 'Terms & Conditions',
                    fontSize: 12,
                    onTap: () {},
                  )
                ],
              ),
              const SizedBox(height: 10),

              /// Sign Up Button
              SocialSignInButton(
                text: TTexts.signup,
                onPressed: _handleSignUp,
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
                      style: TextStyle(color: TColors.black, fontSize: 16),
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
      ),
    );
  }
}
