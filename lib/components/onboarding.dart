import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:pamphere/components/constants.dart';
import 'package:pamphere/components/widgets.dart';
import 'package:pamphere/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //pageview
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              //check if last page
              setState(() {
                isLastPage = (index == 3);
              });
            },
            children: [
              OnboardingPage(
                image: "assets/images/barber.png",
                heading: "Find Your Perfect Style",
                subheading:
                    "Discover top-rated salons and freelance beauty professionals in your area",
              ),
              OnboardingPage(
                image: "assets/images/easy.png",
                heading: "Book With Ease",
                subheading:
                    "Schedule appointments instantly with PampHere's seamless booking system",
              ),
              OnboardingPage(
                image: "assets/images/makeup.png",
                heading: "Expert Services",
                subheading:
                    "Connect with skilled professionals for all your beauty needs",
              ),
              OnboardingPage(
                image: "assets/images/search.png",
                heading: "Ready to Get Started?",
                subheading:
                    "Start connecting with clients, managing appointments, and growing your brand today.",
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: defaultPadding),
              alignment: Alignment(0, 0.9),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //page indicators
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 4,
                    effect: ExpandingDotsEffect(
                        activeDotColor: TWColors.indigo.shade400),
                  ),
                  SizedBox(height: defaultPadding),
                  isLastPage
                      ? PrimaryButton(
                          ontap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('hasSeenOnboarding', true);
                            log("User has seen onboarding");
                            if (mounted) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                            }
                          },
                          child: Center(
                              child: Text(
                            'Get Started',
                            style: TextStyle(
                                fontSize: 16,
                                color: TWColors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        )
                      : PrimaryButton(
                          ontap: () {
                            pageController.nextPage(
                              duration: Durations.medium4,
                              curve: Curves.easeIn,
                            );
                          },
                          child: Center(
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: TWColors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                  SizedBox(height: defaultPadding),
                  GestureDetector(
                      onTap: () {
                        pageController.jumpToPage(3);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(decoration: TextDecoration.underline),
                      )),
                ],
              ))
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  String image;
  String heading;
  String subheading;
  OnboardingPage({
    super.key,
    required this.image,
    required this.heading,
    required this.subheading,
  });
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      decoration: BoxDecoration(color: Colors.white),
      child: SizedBox(
        height: screenHeight,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.7,
              child: Image.asset(image),
            ),
            Text(
              heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: defaultPadding / 2),
            Text(
              subheading,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
