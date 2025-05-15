import 'dart:typed_data';

import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/screens/home/camera_screen.dart';
import 'package:botanicatch/services/auth/auth_service.dart';
import 'package:botanicatch/widgets/buttons/plant_action_button.dart';
import 'package:botanicatch/widgets/buttons/plant_stats_button.dart';
import 'package:botanicatch/widgets/grids/plant_action_grid.dart';
import 'package:botanicatch/widgets/profile/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final ValueNotifier<Uint8List?> profileImgBytes;
  final Function(int) onNavigate;
  const HomeScreen({
    super.key,
    required this.profileImgBytes,
    required this.onNavigate,
  });
  static final AuthService _auth = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);

    return SingleChildScrollView(
      child: BackgroundImage(
        imagePath: "assets/images/home-bg.jpg",
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
                    SvgPicture.asset(
                      "assets/images/botanicatch.svg",
                      height: 45,
                    ),
                    ProfilePicture(
                      profileImgBytes: profileImgBytes,
                      width: 50,
                      height: 50,
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Hi ${user?.username}!",
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
                    onTap: () => onNavigate(2),
                    imagePath: "assets/images/new-plants.svg",
                    title: "New Plants",
                    // TODO: Implement onTap feature
                    mainColor: kGreenColor300,
                    radialColor: kGreenColor500,
                    right: -30,
                    top: -10,
                    cacheWidth: 90,
                    cacheHeight: 90,
                  ),
                  topRightWidget: PlantActionButton(
                    // TODO: Implement onTap feature
                    onTap: () => onNavigate(3),
                    imagePath: "assets/images/your-plants.svg",
                    title: "Your Plants",
                    mainColor: kGreenColor300,
                    radialColor: kGreenColor500,
                    right: -25,
                    top: -25,
                    cacheWidth: 100,
                    cacheHeight: 100,
                  ),
                  bottomLeftWidget: PlantActionButton(
                    // TODO: Implement onTap feature
                    onTap: () => onNavigate(4),
                    imagePath: "assets/images/location.svg",
                    title: "Location",
                    mainColor: kBlueColor100,
                    radialColor: kBlueColor200,
                    right: -15,
                    top: -25,
                    cacheWidth: 90,
                    cacheHeight: 90,
                  ),
                  bottomRightWidget: PlantActionButton(
                    // TODO: Implement onTap feature
                    onTap: () => onNavigate(5),
                    imagePath: "assets/images/settings.svg",
                    title: "Updates",
                    mainColor: kBlueColor100,
                    radialColor: kBlueColor200,
                    right: -15,
                    top: -25,
                    cacheWidth: 100,
                    cacheHeight: 100,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PlantStatsButton(
                      // TODO: Implement onTap feature
                      onTap: () {},
                      useDynamicSubheading: true,
                      dynamicSubheadingTemplate: "{count} new plants recently",
                      subheading: "",
                      heading: "You found:",
                      imagePath: "assets/images/found-plant.svg",
                      cacheWidth: 150,
                      cacheHeight: 150,
                      right: -40,
                      bottom: -40,
                    ),
                    PlantStatsButton(
                      // TODO: Implement onTap feature
                      onTap: () => onNavigate(1),
                      useDynamicSubheading: false,
                      subheading: "Check your recent catches",
                      heading: "View",
                      imagePath: "assets/images/diagnose-plant.svg",
                      cacheWidth: 160,
                      cacheHeight: 160,
                      right: -50,
                      bottom: -50,
                    ),
                  ],
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
