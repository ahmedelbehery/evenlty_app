import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/common/widgets/custom_dropdown.dart';
import 'package:evenlty_app/screens/home/setting_screen/widets/setting_header.dart';
import 'package:evenlty_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingHeader(),

        CustomDropdown<String>(
          label: "Language",
          items: [
            DropdownMenuItem(
              value: "Ar",
              child: Text(
                "Arabic",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.maincolor,
                ),
              ),
            ),
            DropdownMenuItem(
              value: "En",
              child: Text(
                "English",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.maincolor,
                ),
              ),
            ),
          ],
          onChanged: (value) {},
        ),
        CustomDropdown<String>(
          label: "Theme",
          items: [
            DropdownMenuItem(
              value: "Li",
              child: Text(
                "Light",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.maincolor,
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Drk",
              child: Text(
                "Dark",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.maincolor,
                ),
              ),
            ),
          ],
          onChanged: (value) {},
        ),
        SizedBox(height: 280),
        SizedBox(
          width: 361,
          height: 56,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.loginbuttoncolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            },
            child: Row(
              children: [
                Icon(Icons.exit_to_app_outlined),
                SizedBox(width: 10,),
                Text(
                  "Log out",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
