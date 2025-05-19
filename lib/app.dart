import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphere/app_widget.dart';
import 'package:pamphere/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pamphere/blocs/list_salons/list_salons_bloc.dart';
import 'package:pamphere/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:pamphere/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pamphere/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:pamphere/themes/theme_provider.dart';
import 'package:pamphere/themes/themes.dart';
import 'package:provider/provider.dart';
import 'package:salon_repository/salon_repository.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final bool hasSeenOnboarding;
  const MyApp(
    this.userRepository, {
    super.key,
    required this.hasSeenOnboarding,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MultiBlocProvider(
        providers: [
          RepositoryProvider<SalonRepository>(
            create: (_) => FirebaseSalonRepository(),
          ),
          RepositoryProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(myUserRepository: userRepository),
          ),
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(myUserRepository: userRepository),
          ),
          BlocProvider<MyUserBloc>(
            create: (context) => MyUserBloc(myUserRepository: userRepository),
          ),
          BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(userRepository: userRepository),
          ),
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(userRepository: userRepository),
          ),
          BlocProvider<ListSalonsBloc>(
            create: (context) =>
                ListSalonsBloc(salonRepository: context.read<SalonRepository>())
                  ..add(LoadSalons()),
          ),
        ],
        child: MyAppWidget(
            hasSeenOnboarding: hasSeenOnboarding,
            lightMode: lightMode,
            darkMode: darkMode,
            themeMode: themeProvider.themeMode),
      );
    });
  }
}
