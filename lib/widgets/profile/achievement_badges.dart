import 'package:botanicatch/widgets/profile/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              SvgPicture.asset("assets/images/badge.svg"),
              SvgPicture.asset("assets/images/badge.svg"),
              SvgPicture.asset("assets/images/badge.svg"),
              SvgPicture.asset("assets/images/badge.svg"),
            ],
          ),
        ],
      ),
    );
  }
}
