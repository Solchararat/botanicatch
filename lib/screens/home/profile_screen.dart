import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/modals/edit_profile_modal.dart';
import 'package:botanicatch/widgets/profile/achievement_badges.dart';
import 'package:botanicatch/widgets/profile/activity_item.dart';
import 'package:botanicatch/widgets/profile/profile_header.dart';
import 'package:botanicatch/widgets/profile/section_title.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
// TODO: Show modal to edit name and profile picture on tap of the edit button

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  // mock function for generating last activities
  List<Widget> _fetchLastActivities() {
    return List.generate(3, (_) => const ActivityItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Image
          BackgroundImage(
            imagePath: "assets/images/home_bg.jpg",
            hasPadding: false,
          ),

          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                const ProfileHeader(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    // to make the name centered
                    const SizedBox(width: 16),
                    Text(
                      "Guest",
                      style: kSmallTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => const EditProfileModal());
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 0.5, height: 0.5),
                const AchievementBadges(),
                const Divider(thickness: 0.5, height: 0.5),
                ProfileSectionTitle(title: "Last Activities"),
                Column(
                  children: _fetchLastActivities(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
