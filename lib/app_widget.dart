import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphere/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pamphere/components/onboarding.dart';
import 'package:pamphere/pages/home.dart';
import 'package:pamphere/pages/login.dart';

class MyAppWidget extends StatelessWidget {
  final bool hasSeenOnboarding;

  const MyAppWidget({
    super.key,
    required this.hasSeenOnboarding,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: hasSeenOnboarding
          ? BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                //when user is authenticated
                log('User already authenticated');
                return HomePage();
              } else {
                //when NO user authenticated
                log('No authenticated user');
                return LoginPage();
              }
            })
          : Onboarding(),
    );
  }
}
