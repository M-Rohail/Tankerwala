import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -1.0,
    height: 1.15,
  );

  static const heading1 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.6,
    height: 1.2,
  );

  static const heading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.4,
    height: 1.25,
  );

  static const heading3 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  static const bodyLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.6,
  );

  static const bodyMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const labelLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.3,
  );

  static const labelMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  // Urdu poetry style — slightly larger, elegant
  static const urduPoetry = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textOnDarkMuted,
    height: 1.9,
    letterSpacing: 0.3,
  );

  static const urduSubtle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.7,
  );

  static const onDarkTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textOnDark,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const onDarkBody = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textOnDarkMuted,
    height: 1.7,
  );
}