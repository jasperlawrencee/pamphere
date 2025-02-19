import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:pamphere/components/constants.dart';

class PrimaryButton extends StatelessWidget {
  Function() ontap;
  Widget child;

  PrimaryButton({
    super.key,
    required this.ontap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            decoration: BoxDecoration(
                color: TWColors.indigo.shade400,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            width: double.infinity,
            child: Center(child: child)));
  }
}

class SecondaryButton extends StatelessWidget {
  Function() ontap;
  Widget child;

  SecondaryButton({
    super.key,
    required this.ontap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: defaultPadding, horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            width: double.infinity,
            child: Center(child: child)));
  }
}
