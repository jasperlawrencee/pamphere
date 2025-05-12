import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:pamphere/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:pamphere/components/constants.dart';
import 'package:pamphere/components/widgets.dart';
import 'package:pamphere/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //TODO: Create Profile BLoC for fetching user details
  //TODO: Create Profile Page for user to update their details
  //TODO: Create Profile Page for user to update their payment details
  //TODO: Create Profile Page for user to update their address details
  //TODO: Create Profile Page for user to update their appointment history
  //TODO: Create Profile Page for user to update their liked stylists
  //TODO: Create Profile Page for user to update their saved services
  //TODO: Create Profile Page for user to update their dark mode preference
  //TODO: Create Profile Page for user to update their push notification preference
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyUserBloc, MyUserState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                floating: false,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    // Calculate the scroll percentage
                    final double percentage =
                        (constraints.maxHeight - kToolbarHeight) /
                            (MediaQuery.of(context).size.height * 0.25 -
                                kToolbarHeight);
                    return FlexibleSpaceBar(
                      title: percentage < 0.5
                          ? Text(
                              "Jose Rizal",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            )
                          : null,
                      centerTitle: true,
                      collapseMode: CollapseMode.pin,
                      background: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: defaultPadding * 4),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  color: TWColors.indigo.shade300,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person_outline,
                                  color: TWColors.indigo,
                                  size: 36,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: TWColors.indigo,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: defaultPadding),
                          Text(
                            'Jose Rizal',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'sampleEmail@likethis.com',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: defaultPadding * 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '24',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Appointments',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Reviews',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '5',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Favorites',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account & Personal',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: defaultPadding),
                          ButtonSetting(
                            icon: CupertinoIcons.person,
                            label: "Personal Information",
                            endIcon: Icon(Icons.keyboard_arrow_right_rounded),
                          ),
                          ButtonSetting(
                            icon: CupertinoIcons.creditcard,
                            label: "Payment Methods",
                            endIcon: Icon(Icons.keyboard_arrow_right_rounded),
                          ),
                          ButtonSetting(
                            icon: CupertinoIcons.location,
                            label: "My Addresses",
                            endIcon: Icon(Icons.keyboard_arrow_right_rounded),
                          ),
                          SizedBox(height: defaultPadding),
                          Text(
                            'Bookings & Services',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: defaultPadding),
                          ButtonSetting(
                            icon: CupertinoIcons.arrow_counterclockwise,
                            label: "Appointment History",
                            endIcon: Icon(Icons.keyboard_arrow_right_rounded),
                          ),
                          ButtonSetting(
                            icon: CupertinoIcons.heart,
                            label: "Liked Stylists",
                            endIcon: Icon(Icons.keyboard_arrow_right_rounded),
                          ),
                          ButtonSetting(
                            icon: CupertinoIcons.star,
                            label: "My Reviews",
                            endIcon: Icon(Icons.keyboard_arrow_right_rounded),
                          ),
                          ButtonSetting(
                            icon: CupertinoIcons.bookmark,
                            label: "Saved Services",
                            endIcon: Icon(Icons.keyboard_arrow_right_rounded),
                          ),
                          SizedBox(height: defaultPadding),
                          Text(
                            'App Settings',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: defaultPadding),
                          ButtonSetting(
                            icon: CupertinoIcons.moon,
                            label: "Dark Mode",
                            endIcon: SizedBox(
                              height: 1,
                              child: Switch(
                                value: false,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          ButtonSetting(
                            icon: CupertinoIcons.bell,
                            label: "Push Notifications",
                            endIcon: SizedBox(
                              height: 1,
                              child: Switch(
                                value: false,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          SizedBox(height: defaultPadding * 2),
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Center(
                                child: Text("Pamphere Version $appVersion")),
                          ),
                          TertiaryButton(
                            ontap: () {
                              showLogoutDialog(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.square_arrow_right,
                                    color: TWColors.red),
                                SizedBox(width: defaultPadding),
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: TWColors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: defaultPadding * 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
