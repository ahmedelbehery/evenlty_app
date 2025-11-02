import 'package:evenlty_app/common/app_colors.dart';
import 'package:flutter/material.dart';

class Snackbar {
  static showSuccessSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thumb_up_alt_outlined,
              color: AppColors.lightbgcolor,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              message,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        backgroundColor: AppColors.maincolor,
      ),
    );
  }
   static showErrorSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thumb_down_alt_outlined,
              color: AppColors.lightbgcolor,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              message,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        backgroundColor: AppColors.loginbuttoncolor,
      ),
    );
  }
}
