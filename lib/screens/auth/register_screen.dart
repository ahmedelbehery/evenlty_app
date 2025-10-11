import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/common/widgets/custom_main_button.dart';
import 'package:evenlty_app/common/widgets/custom_textfield.dart';
import 'package:evenlty_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "/RegisterScreen";
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(
            fontSize: 20,
            color: AppColors.maincolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Assets.images.logo.image(width: 135, height: 186),
              SizedBox(height: 24),
              CustomTextField(
                hintText: "Name",
                prefixIcon: Assets.icons.nameicon.image(height: 24, width: 24),
              ),
              SizedBox(height: 24),
              CustomTextField(
                hintText: "Email",
                prefixIcon: Assets.icons.email.image(height: 24, width: 24),
              ),
              SizedBox(height: 24),
              CustomTextField(
                hintText: "Password",
                prefixIcon: Assets.icons.password.image(height: 24, width: 24),
              ),
              SizedBox(height: 24),
              CustomTextField(
                hintText: "Re Password",
                prefixIcon: Assets.icons.password.image(height: 24, width: 24),
              ),
              SizedBox(height: 24),
              CustomMainButton(text: "Create Account", onPressed: () {}),
              SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Already Have Account ? "),
                    TextSpan(
                      text: " Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: AppColors.maincolor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                style: Theme.of(context).textTheme.titleMedium,
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
    );
  }
}
