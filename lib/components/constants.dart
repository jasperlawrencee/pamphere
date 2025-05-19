import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';

const defaultPadding = 16.0;

final primaryColor = TWColors.indigo;
final primaryLightColor = TWColors.indigo.shade100;
final secondaryColor = TWColors.rose;

// email regex
RegExp emailRegEx = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
// 8 chars at least one letter and one number
RegExp passwordRegEx = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

String appVersion = "1.0.0";
