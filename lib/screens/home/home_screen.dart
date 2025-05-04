import 'dart:typed_data';

import 'package:botanicatch/services/auth/auth_service.dart';
import 'package:botanicatch/widgets/buttons/plant_action_button.dart';
import 'package:botanicatch/widgets/buttons/plant_stats_button.dart';
import 'package:botanicatch/widgets/grids/plant_action_grid.dart';
import 'package:botanicatch/widgets/profile/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static final AuthService _auth = AuthService.instance;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ValueNotifier<Uint8List?> _profileImgBytes;

  @override
  void initState() {
    super.initState();
    _profileImgBytes = ValueNotifier<Uint8List?>(null);
  }

  @override
  void dispose() {
    _profileImgBytes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      imagePath: "assets/images/home_bg.jpg",
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 45),
                  Image.asset(
                    "assets/images/logo-small.png",
                    cacheWidth: 190,
                    cacheHeight: 100,
                  ),
                  ProfilePicture(
                    profileImgBytes: _profileImgBytes,
                    width: 50,
                    height: 50,
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Hi Guest!",
                    style:
                        kLargeTextStyle.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Anything New?",
                    style: kSmallTextStyle.copyWith(color: kGrayColor250),
                    textAlign: TextAlign.left),
              ),
              const SizedBox(height: 16),
              PlantActionGrid(
                topLeftWidget: PlantActionButton(
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
                topRightWidget: PlantActionButton(
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
                bottomLeftWidget: PlantActionButton(
                  // TODO: Implement onTap feature
                  onTap: () {},
                  imagePath: "assets/images/location.png",
                  title: "Location",
                  mainColor: kBlueColor100,
                  radialColor: kBlueColor200,
                  right: -25,
                  top: -15,
                  cacheWidth: 100,
                  cacheHeight: 100,
                ),
                bottomRightWidget: PlantActionButton(
                  // TODO: Implement onTap feature
                  onTap: () {},
                  imagePath: "assets/images/settings.png",
                  title: "Updates",
                  mainColor: kBlueColor100,
                  radialColor: kBlueColor200,
                  right: -15,
                  top: -15,
                  cacheWidth: 110,
                  cacheHeight: 110,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PlantStatsButton(
                    // TODO: Implement onTap feature
                    onTap: () {},
                    heading: "You found:",
                    subheading: "30 new plants this month",
                    imagePath: "assets/images/found-plant.png",
                    cacheWidth: 108,
                    cacheHeight: 127,
                    right: -10,
                    bottom: -20,
                  ),
                  PlantStatsButton(
                    // TODO: Implement onTap feature
                    onTap: () {},
                    heading: "Diagnose",
                    subheading: "Check your plant's health",
                    imagePath: "assets/images/diagnose-plant.png",
                    cacheWidth: 153,
                    cacheHeight: 140,
                    right: -10,
                    bottom: -30,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "You are now logged in!",
                    style: kSmallTextStyle,
                  ),
                  TextButton(
                      onPressed: () {
                        HomeScreen._auth.signOut();
                      },
                      child: Text(
                        "Log Out",
                        style: kSmallTextStyle.copyWith(color: kGreenColor300),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
