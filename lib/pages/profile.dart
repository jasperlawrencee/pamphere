import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:pamphere/components/constants.dart';
import 'package:pamphere/components/widgets.dart';
import 'package:pamphere/themes/theme_provider.dart';
import 'package:pamphere/utils.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

class ProfilePage extends StatefulWidget {
  final MyUser user;

  const ProfilePage({
    super.key,
    required this.user,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool darkMode = true;
  ////TODO: Create Profile Page for user to update their details
  /// update [payments] [addresses] [reviews] [favorites] [history]
  //TODO: Create Profile Page for user to update their push notification preference
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                // Added container widget for avoiding duplicate leading [back] button
                leading: Container(),
                backgroundColor: Theme.of(context).colorScheme.background,
                expandedHeight: MediaQuery.of(context).size.height * 0.32,
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
                              widget.user.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : null,
                      centerTitle: true,
                      collapseMode: CollapseMode.pin,
                      background: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
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
                            widget.user.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.user.email,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
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
                                    widget.user.history.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Appointments',
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.user.reviews.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Reviews',
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.user.favorites.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Favorites',
                                    style: TextStyle(),
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
                            endIcon: Switch(
                              activeColor: primaryColor,
                              value: themeProvider.isDarkMode,
                              onChanged: (value) {
                                themeProvider
                                    .setThemeMode(value ? 'dark' : 'light');
                              },
                            ),
                          ),
                          ButtonSetting(
                            icon: CupertinoIcons.bell,
                            label: "Push Notifications",
                            endIcon: Switch(
                              activeColor: primaryColor,
                              value: false,
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(height: defaultPadding * 2),
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Center(
                                child: Text("Pamphere Version $appVersion")),
                          ),
                          TertiaryButton(
                            ontap: () => Utils.showLogoutDialog(context),
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
          ),
        ));
  }
}
