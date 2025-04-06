import 'package:app_diett/client/core/constants/colors.dart';
import 'package:app_diett/client/core/constants/images.dart';
import 'package:app_diett/client/core/constants/texts.dart';
import 'package:app_diett/client/presentation/screens/login_screen.dart';
import 'package:app_diett/client/presentation/widgets/custom_text_field.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              TImages.ellipse,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.only(top: 99, left: 23),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: TColors.primary,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: TColors.primaryBackground,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 23),
                  child: RichText(
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    children: [
                      CustomTextField(
                        label: TTexts.name,
                        controller: _nameController,
                        prefixIcon: Icons.person_outline_outlined,
                      ),
                      CustomTextField(
                        label: TTexts.mobilenumber,
                        controller: _mobileController,
                        prefixIcon: Icons.phone_iphone_outlined,
                      ),
                      CustomTextField(
                        label: TTexts.email,
                        controller: _emailController,
                        prefixIcon: Icons.email_outlined,
                      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            TTexts.agree,
                            style: TextStyle(fontSize: 12),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              TTexts.terms,
                              style: TextStyle(
                                color: TColors.primary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            TTexts.signup,
                            style: TextStyle(
                              color: TColors.primaryBackground,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: TColors.black,
                            ),
                          ),
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
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: TColors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          _socialButton(
                              icon: TImages.googlecon,
                              label: TTexts.loginwithgoogle),
                          const SizedBox(height: 20),
                          _socialButton(
                              icon: TImages.facebookcon,
                              label: TTexts.loginwithfacebook),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            TTexts.alreadyhave,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: Text(
                              TTexts.signin,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton({required String icon, required String label}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: Image.asset(
                icon,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: TColors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
