import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:pamphere/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:pamphere/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pamphere/components/constants.dart';
import 'package:pamphere/components/widgets.dart';
import 'package:pamphere/pages/profile.dart';
import 'package:user_repository/user_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AdvancedDrawerController controller = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: controller,
      backdropColor: primaryColor,
      animationCurve: Curves.easeInExpo,
      disabledGestures: true,
      rtlOpening: false,
      drawer: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset("assets/logos/PamphereLogo.png"),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  context.read<SignInBloc>().add(const SignOutRequired());
                  ToastNotifications().infoToast(message: "User Logged Out");
                },
                child: Row(
                  children: [
                    Icon(CupertinoIcons.square_arrow_right,
                        color: Colors.white),
                    SizedBox(width: defaultPadding),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: defaultPadding * 2),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<MyUserBloc, MyUserState>(
            builder: (context, state) {
              if (state.status == MyUserStatus.success) {
                final firstName = state.user!.name.split(' ')[0];
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: handleDrawer,
                          child: Icon(Icons.menu),
                        ),
                        SizedBox(
                          width: defaultPadding,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome, $firstName! 👋",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Get pampered today!',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => MyUserBloc(
                                  myUserRepository:
                                      context.read<UserRepository>()),
                              // Pass User Details Here
                              child: ProfilePage(),
                            ),
                          )),
                      child: state.user!.picture == ""
                          ? Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: TWColors.indigo.shade300,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person_outline,
                                color: TWColors.indigo,
                              ),
                            )
                          : Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: TWColors.indigo.shade300,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      state.user!.picture!,
                                    ),
                                  )),
                            ),
                    ),
                  ],
                );
              } else {
                // insert skeleton loading ui
                return Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: TWColors.neutral,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                );
              }
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: TWColors.gray.shade200,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Find services, stylists, or salons',
                      hintStyle: TextStyle(fontSize: 16),
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                    onChanged: (value) {
                      // Handle search input here
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleDrawer() {
    controller.showDrawer();
  }
}
