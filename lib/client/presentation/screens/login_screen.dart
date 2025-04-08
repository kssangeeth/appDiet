import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_diett/client/core/constants/colors.dart';
import 'package:app_diett/client/core/constants/images.dart';
import 'package:app_diett/client/core/constants/texts.dart';
import 'package:app_diett/client/presentation/screens/forgot_password.dart';
import 'package:app_diett/client/presentation/screens/home_screen.dart';
import 'package:app_diett/client/presentation/screens/sign_up.dart';
import 'package:app_diett/client/presentation/widgets/custom_text_field.dart';
import 'package:app_diett/client/presentation/widgets/otp_textfield.dart';
import 'package:app_diett/client/presentation/widgets/signin_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              TImages.ellipse,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(TTexts.signinerror)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://10.0.2.2:3000/api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Save auth token and user data to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('userData', jsonEncode(data['userData']));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );

        // Navigate to home screen and clear the navigation stack
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Login failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 99),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: const BackButtonCircle(),
        ),
        const SizedBox(height: 30),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 23),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: TTexts.signinn,
                  style: TextStyle(
                    color: TColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                  text: TTexts.welcome,
                  style: TextStyle(
                    color: TColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  label: TTexts.email,
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    // Basic email validation
                    final emailRegExp =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: TTexts.password,
                  prefixIcon: Icons.lock_outlined,
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  suffixIcon: _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    child: Text(
                      TTexts.forgotpassword,
                      style:
                          TextStyle(color: TColors.textPrimary, fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SocialSignInButton(
                        text: TTexts.signin,
                        onPressed: _handleLogin,
                        backgroundColor: TColors.primary,
                        textColor: TColors.primaryBackground,
                      ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(thickness: 1, color: TColors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        TTexts.or,
                        style: const TextStyle(
                          color: TColors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(thickness: 1, color: TColors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SocialSignInButton(
                  text: TTexts.loginwithgoogle,
                  icon: Image.asset(
                    TImages.googlecon,
                    width: 18,
                    height: 18,
                  ),
                  onPressed: () {
                    // Google Sign In Logic
                  },
                ),
                const SizedBox(height: 20),
                SocialSignInButton(
                  text: TTexts.loginwithfacebook,
                  icon: Image.asset(
                    TImages.facebookcon,
                    width: 18,
                    height: 18,
                  ),
                  onPressed: () {
                    // Facebook Sign In Logic
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      TTexts.newmember,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        TTexts.signup,
                        style: TextStyle(
                          color: TColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
