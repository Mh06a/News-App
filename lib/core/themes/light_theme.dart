import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.primary,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.surface,
    onPrimary: AppColors.textOnPrimary,
    onSurface: AppColors.textPrimary,
  ),
  dividerColor: AppColors.divider,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textPrimary),
    bodyMedium: TextStyle(color: AppColors.textSecondary),
  ),

  // here I will set elevatedButton Theme :
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      textStyle: TextStyle(
        fontSize: AppSizes.font16,
        fontWeight: FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  ),

  // here I will set bottomNavigationBar Theme :
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.background,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: AppColors.secondary,
    selectedItemColor: AppColors.primary,
    showUnselectedLabels: true,
  ),

  // here I will set appBar theme :
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.appBarBackground,
    titleTextStyle: TextStyle(
      fontSize: AppSizes.font16,
      fontWeight: FontWeight.w700,
      color: AppColors.textThirdColor,
    ),
  ),
);
