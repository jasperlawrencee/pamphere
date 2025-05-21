import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:pamphere/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:pamphere/components/constants.dart';
import 'package:pamphere/components/salon_list.dart';
import 'package:pamphere/pages/profile.dart';
import 'package:pamphere/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AdvancedDrawerController controller = AdvancedDrawerController();
  String defaultFilter = 'All';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: controller,
      backdropColor: primaryColor,
      animationCurve: Curves.easeInExpo,
      disabledGestures: false,
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
                onTap: () => Utils.showLogoutDialog(context),
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
          backgroundColor: Theme.of(context).colorScheme.background,
          scrolledUnderElevation: 0,
          title: BlocBuilder<MyUserBloc, MyUserState>(
            builder: (context, state) {
              if (state.status == MyUserStatus.success) {
                // Display user's first name in the app bar using [state.user!.name]
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
                      onTap: () {
                        // navigate to profile page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              user: state.user!,
                            ),
                          ),
                        );
                      },
                      child: state.user!.picture == ""
                          ? Container(
                              width: 46,
                              height: 46,
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
                              width: 46,
                              height: 46,
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
                            // Name Skeleton
                            Container(
                              width: 200,
                              height: 36,
                              decoration: BoxDecoration(
                                color: TWColors.gray.shade200,
                                borderRadius: BorderRadius.circular(8),
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
                    Container(
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
                  ],
                );
              }
            },
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.background,
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Search bar
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TWColors.gray.shade300,
                      width: 2,
                    ),
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
                      setState(() {
                        searchQuery = value.trim();
                      });
                    },
                  ),
                ),
                // Filter bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultPadding),
                        margin: EdgeInsets.only(bottom: defaultPadding),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: TWColors.gray.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: defaultFilter,
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            items: [
                              DropdownMenuItem(
                                value: 'All',
                                child: Text('All'),
                              ),
                              DropdownMenuItem(
                                value: 'Salons',
                                child: Text('Salons'),
                              ),
                              DropdownMenuItem(
                                value: 'Freelancers',
                                child: Text('Freelancers'),
                              )
                            ],
                            onChanged: (value) {
                              setState(() {
                                defaultFilter = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: defaultPadding),
                    // sort by button
                    Container(
                      height: 52,
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      margin: EdgeInsets.only(bottom: defaultPadding),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: TWColors.gray.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: showFilterBottomSheet,
                              child: Icon(CupertinoIcons.slider_horizontal_3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // List of salons
                Expanded(
                    child: SalonList(
                  filter: defaultFilter,
                  searchQuery: searchQuery,
                )),
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

  //TODO: implement filter bottom sheet
  void showFilterBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(),
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(defaultPadding),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('Filter by',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                //TODO: Implement filtering options
                Text('Price'),
                Text('Rating'),
                Text('Nearest Me'),
              ]));
        });
  }
}
