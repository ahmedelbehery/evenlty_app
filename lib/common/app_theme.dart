import 'package:evenlty_app/common/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    dividerTheme: DividerThemeData(color: AppColors.maincolor),
    scaffoldBackgroundColor: AppColors.lightbgcolor,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.maincolor,primary: AppColors.maincolor),
    hintColor: AppColors.greycolor,
    hoverColor: AppColors.greycolor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightbgcolor,
      iconTheme: IconThemeData(color: AppColors.maincolor),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.maincolor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: _getTextTheme(AppColors.lighttxtcolor),
  );
  static ThemeData darkTheme = ThemeData(
    dividerTheme: DividerThemeData(color: AppColors.maincolor),
    scaffoldBackgroundColor: AppColors.darkbgcolor,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.maincolor,primary: AppColors.maincolor),
    hintColor: AppColors.maincolor,
    hoverColor: AppColors.darktxtcolor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkbgcolor,
      iconTheme: IconThemeData(color: AppColors.maincolor),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.maincolor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: _getTextTheme(AppColors.darktxtcolor),
  );
  static TextTheme _getTextTheme(Color textColor) {
    return TextTheme(
      labelSmall: TextStyle(
        color: textColor,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        color: textColor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
