import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/common/widgets/custom_dropdown.dart';
import 'package:evenlty_app/provider/event_provider.dart';
import 'package:evenlty_app/provider/setting_provider.dart';
import 'package:evenlty_app/provider/user_provider.dart';
import 'package:evenlty_app/screens/home/setting_screen/widets/setting_header.dart';
import 'package:evenlty_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SettingHeader(),
        CustomDropdown<String>(
          label: "Language",
          value: Provider.of<SettingProvider>(context).local,
          items: const [
            DropdownMenuItem(
              value: "ar",
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
              value: "en",
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
          onChanged: (value) {
            if (value != null) {
              Provider.of<SettingProvider>(
                context,
                listen: false,
              ).editLocalization(value);
            }
          },
        ),
        CustomDropdown<ThemeMode>(
          label: "Theme",
          value: Provider.of<SettingProvider>(context).appTheme,
          items: const [
            DropdownMenuItem(
              value: ThemeMode.light,
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
              value: ThemeMode.dark,
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
          onChanged: (value) {
            if (value != null) {
              Provider.of<SettingProvider>(
                context,
                listen: false,
              ).editThemeMode(value);
            }
          },
        ),
        const SizedBox(height: 280),
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
              Provider.of<EventProvider>(context, listen: false).clear();
              Provider.of<UserProvider>(context, listen: false).logout();

              
              Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routeName,
                (route) => false,
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.exit_to_app_outlined, color: Colors.white),
                SizedBox(width: 10),
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
