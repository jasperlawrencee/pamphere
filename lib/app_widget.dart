import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphere/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pamphere/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:pamphere/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pamphere/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:pamphere/components/onboarding.dart';
import 'package:pamphere/pages/home.dart';
import 'package:pamphere/pages/login.dart';

class MyAppWidget extends StatelessWidget {
  final ThemeData lightMode;
  final ThemeData darkMode;
  final ThemeMode themeMode;
  final bool hasSeenOnboarding;

  const MyAppWidget({
    super.key,
    required this.hasSeenOnboarding,
    required this.lightMode,
    required this.darkMode,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeMode,
      // theme: ThemeData(
      //   fontFamily: 'Poppins',
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: hasSeenOnboarding
          ? BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                //when user is authenticated
                log('User already authenticated');
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => SignInBloc(
                        userRepository:
                            context.read<AuthenticationBloc>().userRepository,
                      ),
                    ),
                    BlocProvider(
                      create: (context) => UpdateUserInfoBloc(
                          userRepository: context
                              .read<AuthenticationBloc>()
                              .userRepository),
                    ),
                    BlocProvider(
                      create: (context) => MyUserBloc(
                          myUserRepository:
                              context.read<AuthenticationBloc>().userRepository)
                        ..add(
                          GetMyUser(
                              myUserId: context
                                  .read<AuthenticationBloc>()
                                  .state
                                  .user!
                                  .uid),
                        ),
                    ),
                  ],
                  child: HomePage(),
                );
              } else {
                //when NO user authenticated
                log('No authenticated user');
                return BlocProvider<SignInBloc>(
                  create: (context) => SignInBloc(
                      userRepository:
                          context.read<AuthenticationBloc>().userRepository),
                  child: LoginPage(),
                );
              }
            })
          : Onboarding(),
    );
  }
}
