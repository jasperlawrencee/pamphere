import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:pamphere/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pamphere/components/background.dart';
import 'package:pamphere/components/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome 👋",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Welcome text that might be this long',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: TWColors.gray,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, index) => Text("item $index"),
          ),
        ),
      ),
    );
  }
}
