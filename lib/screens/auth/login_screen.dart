import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/common/widgets/custom_main_button.dart';
import 'package:evenlty_app/common/widgets/custom_outline_button.dart';
import 'package:evenlty_app/common/widgets/custom_textfield.dart';
import 'package:evenlty_app/gen/assets.gen.dart';
import 'package:evenlty_app/network/auth_service.dart';
import 'package:evenlty_app/screens/auth/register_screen.dart';
import 'package:evenlty_app/screens/home/main_layer_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/loginScreen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Assets.images.logo.image(width: 135, height: 186),
                SizedBox(height: 24),
                CustomTextField(
                  hintText: "Email",
                  prefixIcon: Assets.icons.email.image(height: 24, width: 24),
                ),
                SizedBox(height: 16),
                CustomTextField(
                  hintText: "Password",
                  prefixIcon: Assets.icons.password.image(
                    height: 24,
                    width: 24,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.maincolor,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                CustomMainButton(text: "Login", onPressed: () {}),
                SizedBox(height: 24),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Don’t Have Account ? "),
                      TextSpan(
                        text: " Create Account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: AppColors.maincolor,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(
                              context,
                            ).pushNamed(RegisterScreen.routeName);
                          },
                      ),
                    ],
                  ),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 24),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(child: Divider(indent: 16)),
                    Text(
                      "Or",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.maincolor,
                      ),
                    ),
                    Expanded(child: Divider(endIndent: 16)),
                  ],
                ),
                SizedBox(height: 24),
                CustomOutlineButton(
                  onPressed: () async {
                    final user = await AuthService.signInWithGoogle(context);
                    if (user != null) {
                      Navigator.of(context).pushNamed(MainLayerScreen.routeName);
                    }
                  },
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.googleicon.image(height: 26, width: 26),
                      Text(
                        "Login With ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.maincolor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Switch(
                  value: true,
                  onChanged: (value) {},
                  activeThumbImage: AssetImage(Assets.icons.lr.path),
                  inactiveThumbImage: AssetImage(Assets.icons.eg.path),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
