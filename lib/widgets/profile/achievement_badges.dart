import 'package:botanicatch/models/badge_model.dart';
import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/services/badges/badge_service.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/profile/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AchievementBadges extends StatelessWidget {
  const AchievementBadges({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserModel?>(context);
    final BadgeService badgeService = BadgeService();

    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(color: kGreenColor300),
      );
    }

    if (user.badges.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        badgeService.initializeUserBadges(user);
      });

      return _buildBadgePlaceholders();
    }

    List<BadgeModel> badgesToDisplay = _getSortedBadges(user.badges);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 16,
        children: [
          const ProfileSectionTitle(title: "Achievements"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: badgesToDisplay
                .map((badge) => _buildBadgeItem(context, badge))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem(BuildContext context, BadgeModel badge) {
    return GestureDetector(
      onTap: () => _showBadgeDetails(context, badge),
      child: Tooltip(
        message: badge.isUnlocked ? badge.name : 'Locked: ${badge.description}',
        child: SvgPicture.asset(
          badge.isUnlocked ? badge.unlockedAssetPath : badge.assetPath,
          height: 70,
        ),
      ),
    );
  }

  void _showBadgeDetails(BuildContext context, BadgeModel badge) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2D936C),
        title: Text(
          badge.name,
          style: kMediumTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              badge.isUnlocked ? badge.unlockedAssetPath : badge.assetPath,
              height: 100,
            ),
            const SizedBox(height: 16),
            Text(
              badge.description,
              style: kXXSmallTextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              badge.isUnlocked
                  ? 'Unlocked!'
                  : 'Keep exploring to unlock this badge!',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: badge.isUnlocked ? kGreenColor500 : kGrayColor300,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close',
                style: kXXSmallTextStyle.copyWith(color: kGreenColor300)),
          ),
        ],
      ),
    );
  }

  List<BadgeModel> _getSortedBadges(List<BadgeModel> badges) {
    final sortedBadges = List<BadgeModel>.from(badges);

    sortedBadges.sort((a, b) {
      if (a.isUnlocked && !b.isUnlocked) return -1;
      if (!a.isUnlocked && b.isUnlocked) return 1;
      return 0;
    });

    while (sortedBadges.length < 4) {
      sortedBadges.add(BadgeModel(
        id: 'placeholder_${sortedBadges.length}',
        name: 'Mystery Badge',
        description: 'Keep exploring to discover new achievements',
        assetPath: 'assets/images/badge.svg',
        unlockedAssetPath: 'assets/images/badge.svg',
      ));
    }

    return sortedBadges.take(4).toList();
  }

  Widget _buildBadgePlaceholders() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 16,
        children: [
          const ProfileSectionTitle(title: "Achievements"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: List.generate(
              4,
              (index) =>
                  SvgPicture.asset("assets/images/badge.svg", height: 70),
            ),
          ),
        ],
      ),
    );
  }
}
