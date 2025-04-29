import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/buttons/plant_action_button.dart';
import 'package:flutter/material.dart';
import 'package:botanicatch/services/auth_service.dart';
import 'package:botanicatch/widgets/navbars/custom_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ValueNotifier<int> _currentScreenIndex;

  static final AuthService _auth = AuthService();

  void _navigateOnPress(int index) {
    _currentScreenIndex.value = index;
  }

  @override
  void initState() {
    super.initState();
    _currentScreenIndex = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _currentScreenIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: BackgroundImage(
        imagePath: "assets/images/home_bg.jpg",
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 45),
                    Image.asset(
                      "assets/images/logo-small.png",
                      cacheWidth: 190,
                      cacheHeight: 100,
                    ),
                    Image.asset("assets/images/user.png")
                  ],
                ),
                Text("Hi Guest!",
                    style:
                        kLargeTextStyle.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left),
                Text("Anything New?",
                    style: kSmallTextStyle.copyWith(color: kGrayColor250),
                    textAlign: TextAlign.left),
                const SizedBox(height: 16),
                Column(
                  spacing: 16,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PlantActionButton(
                          onTap: () {},
                          imagePath: "assets/images/new-plants.png",
                          title: "New Plants",
                          // TODO: Implement onTap feature
                          mainColor: kGreenColor300,
                          radialColor: kGreenColor500,
                          right: -40,
                          top: -20,
                          cacheWidth: 110,
                          cacheHeight: 110,
                        ),
                        PlantActionButton(
                          // TODO: Implement onTap feature
                          onTap: () {},
                          imagePath: "assets/images/your-plants.png",
                          title: "Your Plants",
                          mainColor: kGreenColor300,
                          radialColor: kGreenColor500,
                          right: -35,
                          top: -35,
                          cacheWidth: 125,
                          cacheHeight: 125,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PlantActionButton(
                          // TODO: Implement onTap feature
                          onTap: () {},
                          imagePath: "assets/images/location.png",
                          title: "Location",
                          mainColor: kBlueColor100,
                          radialColor: kBlueColor200,
                          right: -25,
                          top: -25,
                          cacheWidth: 100,
                          cacheHeight: 100,
                        ),
                        PlantActionButton(
                          // TODO: Implement onTap feature
                          onTap: () {},
                          imagePath: "assets/images/settings.png",
                          title: "Location",
                          mainColor: kBlueColor100,
                          radialColor: kBlueColor200,
                          right: -15,
                          top: -25,
                          cacheWidth: 110,
                          cacheHeight: 110,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "You are now logged in!",
                          style: kSmallTextStyle,
                        ),
                        TextButton(
                            onPressed: () {
                              _auth.signOut();
                            },
                            child: Text(
                              "Log Out",
                              style: kSmallTextStyle.copyWith(
                                  color: kGreenColor300),
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndexNotifier: _currentScreenIndex,
        onDestinationSelect: (int index) => _navigateOnPress(index),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            height: 64,
            width: 64,
            child: FloatingActionButton(
              onPressed: () {},
              elevation: 0,
              backgroundColor: kGreenColor300,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 10, color: kGreenColor500),
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
            ),
          ),
          Text('Catch',
              style: kXXSmallTextStyle.copyWith(
                  fontSize: 11, color: kGrayColor250)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
