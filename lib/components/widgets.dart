import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:pamphere/components/constants.dart';
import 'package:toastification/toastification.dart';

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
            height: 60,
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
            height: 60,
            padding: EdgeInsets.symmetric(
                vertical: defaultPadding, horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            width: double.infinity,
            child: Center(child: child)));
  }
}

class TertiaryButton extends StatelessWidget {
  Function() ontap;
  Widget child;

  TertiaryButton({
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
                color: TWColors.red.shade200,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            width: double.infinity,
            child: Center(child: child)));
  }
}

class MyTextFormField extends StatelessWidget {
  final String? Function(String?) validator;
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  IconData? prefixIcon;
  Widget? suffixIcon;

  MyTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  size: 20,
                )
              : null,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(
            vertical: defaultPadding,
            horizontal: defaultPadding / 2,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
      keyboardType: TextInputType.emailAddress,
      validator: validator,
    );
  }
}

class ToastNotifications {
  sucessToast({required String message}) {
    toastification.show(
      title: Text(message),
      style: ToastificationStyle.flatColored,
      type: ToastificationType.success,
      autoCloseDuration: Duration(seconds: 5),
      alignment: Alignment.topCenter,
    );
  }

  failToast({required String message}) {
    toastification.show(
      title: Text(message),
      style: ToastificationStyle.flatColored,
      type: ToastificationType.error,
      autoCloseDuration: Duration(seconds: 5),
      alignment: Alignment.topCenter,
    );
  }

  infoToast({required String message}) {
    toastification.show(
      title: Text(message),
      style: ToastificationStyle.flatColored,
      type: ToastificationType.info,
      autoCloseDuration: Duration(seconds: 5),
      alignment: Alignment.topCenter,
    );
  }
}

class ButtonSetting extends StatelessWidget {
  IconData icon;
  String label;
  Widget endIcon;

  ButtonSetting({
    required this.icon,
    required this.label,
    required this.endIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: defaultPadding),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: TWColors.indigo,
                    ),
                    SizedBox(width: defaultPadding),
                    Text(
                      label,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  height: 28,
                  child: endIcon,
                ),
              ],
            ),
            SizedBox(height: defaultPadding / 2),
            Divider(color: TWColors.gray.shade300),
          ],
        ),
      ),
    );
  }
}
