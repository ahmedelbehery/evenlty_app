import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/common/widgets/custom_main_button.dart';
import 'package:evenlty_app/common/widgets/custom_textfield.dart';
import 'package:evenlty_app/common/widgets/snakbar.dart';
import 'package:evenlty_app/gen/assets.gen.dart';
import 'package:evenlty_app/models/user_model.dart';
import 'package:evenlty_app/network/auth_service.dart';
import 'package:evenlty_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/RegisterScreen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Assets.images.logo.image(width: 135, height: 186),
                SizedBox(height: 24),
                CustomTextField(
                  controller: nameController,
                  hintText: "Name",
                  prefixIcon: Assets.icons.nameicon.image(
                    height: 24,
                    width: 24,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: Assets.icons.email.image(height: 24, width: 24),
                  validator: (value) {
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value ?? "");
                    if (value == null || value.isEmpty) {
                      return "email is required";
                    } else if (!emailValid) {
                      return "Email is not Vaild";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  isPassword: true,
                  prefixIcon: Assets.icons.password.image(
                    height: 24,
                    width: 24,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "password is required";
                    } else if (value.length < 8) {
                      return "password must be at least 8 character";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirms Password",
                  isPassword: true,
                  prefixIcon: Assets.icons.password.image(
                    height: 24,
                    width: 24,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "confirm password is required";
                    } else if (value != passwordController.text) {
                      return "password dones't match ";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  CustomMainButton(
                    text: "Sign Up",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          await AuthService.register(
                            passwordController.text.trim(),
                            UserModel(
                              email: emailController.text.trim(),
                              name: nameController.text.trim(),
                            ),
                          );

                          if (mounted) {
                            Snackbar.showSuccessSnackBar(
                              context: context,
                              message: "Sign Up Successful",
                            );
                            Navigator.of(
                              context,
                            ).pushNamed(LoginScreen.routeName);
                          }
                        } catch (e) {
                          if (mounted) {
                            Snackbar.showErrorSnackBar(
                              context: context,
                              message: e.toString(),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      }
                    },
                  ),

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
      ),
    );
  }
}
