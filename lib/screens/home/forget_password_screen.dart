import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/common/widgets/custom_main_button.dart';
import 'package:evenlty_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});
  static const String routeName = "/ForgetPasswordScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forget Password",
          style: TextStyle(
            fontSize: 20,
            color: AppColors.maincolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Assets.images.forgetpassword.image(
              height: 335,
              width: 343,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 42,),
            CustomMainButton(text: "Foregt Password",onPressed: (){},)
          ],
        ),
      ),
    );
  }
}
