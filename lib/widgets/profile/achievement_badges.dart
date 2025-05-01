import 'package:botanicatch/widgets/profile/section_title.dart';
import 'package:flutter/material.dart';

class AchievementBadges extends StatelessWidget {
  const AchievementBadges({super.key});

  // TODO: Function that changes the face of the badge when an achievement is made.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 16,
        children: [
          const ProfileSectionTitle(title: "Achievements"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              Image.asset("assets/images/badge.png"),
              Image.asset("assets/images/badge.png"),
              Image.asset("assets/images/badge.png"),
              Image.asset("assets/images/badge.png"),
            ],
          ),
        ],
      ),
    );
  }
}
