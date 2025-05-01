import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/profile/achievement_badges.dart';
import 'package:botanicatch/widgets/profile/activity_item.dart';
import 'package:botanicatch/widgets/profile/profile_picture.dart';
import 'package:botanicatch/widgets/profile/section_title.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // mock function for generating last activities
  List<Widget> _fetchLastActivities() {
    return List.generate(3, (_) => const ActivityItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Image
          BackgroundImage(
            imagePath: "assets/images/home_bg.jpg",
            hasPadding: false,
          ),

          // Banner Image
          // Photo by <a href="https://unsplash.com/@vladutremus?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Vladut Tomsa</a> on <a href="https://unsplash.com/photos/green-trees-on-green-grass-field-under-blue-sky-during-daytime-HrsJTdMqfvg?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
          // TODO: Implement banner uploading if required.
          Image.asset("assets/images/banner.jpg",
              width: MediaQuery.of(context).size.width * 1,
              height: 200,
              fit: BoxFit.cover),

          // Profile Picture
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const SizedBox(height: 140),
                const ProfilePicture(),
              ],
            ),
          ),

          Center(
            child: Column(
              spacing: 16,
              children: [
                // accounts the size of the banner
                const SizedBox(height: 230),
                Text("Uncle Kevin",
                    style: kSmallTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    )),

                const Divider(thickness: 0.5, height: 0.5),
                const AchievementBadges(),
                const Divider(thickness: 0.5, height: 0.5),

                const ProfileSectionTitle(title: "Last Activities"),

                Column(
                  spacing: 16,
                  children: _fetchLastActivities(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
