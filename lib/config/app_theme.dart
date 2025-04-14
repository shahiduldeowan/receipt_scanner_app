import 'package:flutter/material.dart';

class AppColors {
  static const Color errorColor = Color(0xFFFF494C);
  static const Color fontDarkColor = Color(0xFF0D101C);
  static const Color fontSlateGray = Color(0xFF6E7591);
  static const Color gradientRightColor = Color(0xFF1A1D23);
  static const Color greenColor = Color(0xFF34C759);
  static const Color iceGray = Color(0xFF2F343A);
  static const Color iconStoneGray = Color(0xFF4F525A);
  static const Color onErrorColor = Color(0xFF6D7491);
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFF613BE7);
  static const Color primaryContainerColor = Color(0xFF1A1D23);
  static const Color appBorderGay = Color(0xFF2F343A);

  static final ColorScheme darkColorScheme = const ColorScheme.dark(
    primary: primaryColor,
    primaryContainer: primaryContainerColor,
    onError: onErrorColor,
    onPrimary: onPrimaryColor,
  );
}

class ThemeHelper {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.standard,
    colorScheme: AppColors.darkColorScheme,
    scaffoldBackgroundColor: AppColors.gradientRightColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.onPrimaryColor,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

class DarkCodeColors {
  Color get darkBlack => AppColors.fontDarkColor;
  Color get slateGray => AppColors.fontSlateGray;
  Color get stoneGray => AppColors.iconStoneGray;
  Color get green => AppColors.greenColor;
  Color get error => AppColors.errorColor;
  Color get iceGray => AppColors.iceGray;
  Color get appBorderGay => AppColors.appBorderGay;
}
