import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String topImage, bottomImage;
  const Background(
      {super.key,
      required this.child,
      this.topImage = "assets/images/main_top.png",
      this.bottomImage = "assets/images/main_bottom.png"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: TWColors.purple.shade50,
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(topImage),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Transform.flip(
                flipX: true,
                child: Image.asset(bottomImage),
              ),
            ),
            SafeArea(child: child)
          ],
        ),
      ),
    );
  }
}
