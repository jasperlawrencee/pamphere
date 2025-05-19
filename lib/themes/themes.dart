import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:pamphere/components/constants.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: TWColors.gray.shade50,
    primary: primaryColor,
    secondary: primaryLightColor,
    tertiary: TWColors.gray.shade600,
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      background: TWColors.gray.shade900,
      primary: TWColors.indigo.shade900,
      secondary: TWColors.gray.shade800,
      tertiary: TWColors.gray.shade400),
);
