import 'package:app_diett/client/presentation/widgets/custom_text_field.dart';
import 'package:app_diett/client/presentation/widgets/signin_button.dart';
import 'package:flutter/material.dart';
import 'package:app_diett/client/core/constants/colors.dart';
import 'package:app_diett/client/core/constants/images.dart';
import 'package:app_diett/client/core/constants/texts.dart';
import 'package:app_diett/client/presentation/screens/forgot_password.dart';
import 'package:app_diett/client/presentation/screens/home_screen.dart';
import 'package:app_diett/client/presentation/screens/sign_up.dart'; // Your reusable button

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

  void _handleLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(TTexts.signinerror)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 99, left: 23),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: TColors.primary,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: TColors.primaryBackground,
              ),
            ),
          ),
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
          child: Column(
            children: [
              CustomTextField(
                label: TTexts.email,
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: TTexts.password,
                prefixIcon: Icons.lock_outlined,
                controller: _passwordController,
                obscureText: true,
                suffixIcon: Icons.visibility_outlined,
                onSuffixTap: () {
                  // Add toggle password visibility logic here later if needed
                },
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
                    style: TextStyle(color: TColors.textPrimary, fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SocialSignInButton(
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
                          builder: (context) => const SignUp(),
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
      ],
    );
  }
}
