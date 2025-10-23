import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/common/widgets/custom_main_button.dart';
import 'package:evenlty_app/common/widgets/custom_outline_button.dart';
import 'package:evenlty_app/common/widgets/custom_textfield.dart';
import 'package:evenlty_app/common/widgets/snakbar.dart';
import 'package:evenlty_app/gen/assets.gen.dart';
import 'package:evenlty_app/models/user_model.dart';
import 'package:evenlty_app/network/auth_service.dart';
import 'package:evenlty_app/screens/home/forget_password_screen.dart';
import 'package:evenlty_app/screens/home/main_layer_screen.dart';
import 'package:evenlty_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/loginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Assets.images.logo.image(width: 135, height: 186),
                  SizedBox(height: 24),
                  CustomTextField(
                    hintText: "Email",
                    controller: emailController,
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
                  SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Password",
                    controller: passwordController,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushNamed(ForgetPasswordScreen.routeName);
                        },
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
                  if (isLoading)
                    const CircularProgressIndicator()
                  else
                    CustomMainButton(
                      text: "Login",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            UserModel? user = await AuthService.login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );

                            if (user != null) {
                              if (mounted) {
                                Snackbar.showSuccessSnackBar(
                                  context: context,
                                  message: "Login Successful",
                                );
                              }

                              setState(() {
                                isLoading = false;
                              });

                              if (mounted) {
                                Navigator.of(
                                  context,
                                ).pushNamed(MainLayerScreen.routeName);
                              }
                            }
                          } on FirebaseAuthException catch (e) {
                            if (mounted) {
                              Snackbar.showErrorSnackBar(
                                context: context,
                                message:
                                    e.message ?? "Invalid email or password",
                              );
                            }

                            setState(() {
                              isLoading = false;
                            });
                          } catch (e) {
                            if (mounted) {
                              Snackbar.showErrorSnackBar(
                                context: context,
                                message: "Login failed. Please try again.",
                              );
                            }

                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                    ),

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
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icons.googleicon.image(height: 26, width: 26),
                        Text(
                          "Login With Google",
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
      ),
    );
  }
}
