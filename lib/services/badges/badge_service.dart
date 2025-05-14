import 'dart:developer';

import 'package:botanicatch/models/badge_model.dart';
import 'package:botanicatch/models/plant_model.dart';
import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/services/db/db_service.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BadgeService {
  static final BadgeService _instance = BadgeService._internal();
  factory BadgeService() => _instance;
  BadgeService._internal();

  final List<BadgeModel> _availableBadges = [
    BadgeModel(
      id: 'first_leaf',
      name: 'First Leaf',
      description: 'Discover your first plant',
      assetPath: 'assets/images/badge.svg',
      unlockedAssetPath: 'assets/images/first-leaf-badge.svg',
    ),
    BadgeModel(
      id: 'leaf_collector',
      name: 'Leaf Collector',
      description: 'Discover 10 different plants',
      assetPath: 'assets/images/badge.svg',
      unlockedAssetPath: 'assets/images/leaf-collector-badge.svg',
    ),
    BadgeModel(
      id: 'native_botanist',
      name: 'Native Botanist',
      description: 'Discover 5 different native type plants',
      assetPath: 'assets/images/badge.svg',
      unlockedAssetPath: 'assets/images/native-botanist-badge.svg',
    ),
    BadgeModel(
      id: 'plantdex_apprentice',
      name: 'Plantdex Apprentice',
      description: 'Discover 30 different plants',
      assetPath: 'assets/images/badge.svg',
      unlockedAssetPath: 'assets/images/plantdex-apprentice-badge.svg',
    ),
  ];

  List<BadgeModel> get availableBadges => _availableBadges;

  Future<List<BadgeModel>> checkAndUpdateBadges(
      UserModel user, PlantModel newPlant) async {
    if (user.uid == null) return [];

    final DatabaseService databaseService = DatabaseService(uid: user.uid!);

    final Map<String, int> updatedStats = Map.from(user.stats);
    updatedStats['totalPlantsDiscovered'] =
        (updatedStats['totalPlantsDiscovered'] ?? 0) + 1;

    final allPlants = await databaseService.getAllPlants();

    final bool isUniquePlant = !allPlants.any((plant) =>
        plant.scientificName == newPlant.scientificName &&
        plant.plantId != newPlant.plantId);

    if (isUniquePlant) {
      updatedStats['uniquePlantsDiscovered'] =
          (updatedStats['uniquePlantsDiscovered'] ?? 0) + 1;

      if (newPlant.type.contains('native')) {
        updatedStats['nativePlantsDiscovered'] =
            (updatedStats['nativePlantsDiscovered'] ?? 0) + 1;
      }
    }

    List<BadgeModel> currentBadges = List.from(user.badges);

    List<BadgeModel> newlyUnlockedBadges = [];

    if (!_hasBadge(currentBadges, 'first_leaf') &&
        updatedStats['totalPlantsDiscovered']! >= 1) {
      final badge = _getBadge('first_leaf').copyWith(isUnlocked: true);
      newlyUnlockedBadges.add(badge);
      currentBadges = _addOrUpdateBadge(currentBadges, badge);
    }

    if (!_hasBadge(currentBadges, 'leaf_collector') &&
        updatedStats['uniquePlantsDiscovered']! >= 10) {
      final badge = _getBadge('leaf_collector').copyWith(isUnlocked: true);
      newlyUnlockedBadges.add(badge);
      currentBadges = _addOrUpdateBadge(currentBadges, badge);
    }

    if (!_hasBadge(currentBadges, 'native_botanist') &&
        updatedStats['nativePlantsDiscovered']! >= 5) {
      final badge = _getBadge('native_botanist').copyWith(isUnlocked: true);
      newlyUnlockedBadges.add(badge);
      currentBadges = _addOrUpdateBadge(currentBadges, badge);
    }

    if (!_hasBadge(currentBadges, 'plantdex_apprentice') &&
        updatedStats['uniquePlantsDiscovered']! >= 30) {
      final badge = _getBadge('plantdex_apprentice').copyWith(isUnlocked: true);
      newlyUnlockedBadges.add(badge);
      currentBadges = _addOrUpdateBadge(currentBadges, badge);
    }

    await Future.wait([
      databaseService.updateUserStats(updatedStats),
      databaseService.updateUserBadges(currentBadges)
    ]);

    return newlyUnlockedBadges;
  }

  BadgeModel _getBadge(String badgeId) {
    return _availableBadges.firstWhere(
      (badge) => badge.id == badgeId,
      orElse: () => throw Exception('Badge not found: $badgeId'),
    );
  }

  bool _hasBadge(List<BadgeModel> badges, String badgeId) {
    return badges.any((badge) => badge.id == badgeId && badge.isUnlocked);
  }

  List<BadgeModel> _addOrUpdateBadge(
      List<BadgeModel> badges, BadgeModel newBadge) {
    final index = badges.indexWhere((badge) => badge.id == newBadge.id);
    if (index >= 0) {
      final updatedBadges = List<BadgeModel>.from(badges);
      updatedBadges[index] = newBadge;
      return updatedBadges;
    } else {
      return [...badges, newBadge];
    }
  }

  Future<void> initializeUserBadges(UserModel user) async {
    if (user.uid == null) return;

    if (user.badges.isEmpty) {
      final databaseService = DatabaseService(uid: user.uid!);
      await databaseService.updateUserBadges(_availableBadges);
    }
  }

  void showBadgeEarnedDialog(BuildContext context, BadgeModel badge) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2D936C),
        title: Text(
          'Badge Earned!',
          style: kMediumTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(badge.unlockedAssetPath, height: 100),
            const SizedBox(height: 16),
            Text(badge.name,
                style: kSmallTextStyle.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              badge.description,
              style: kXXSmallTextStyle,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Awesome!',
              style: kXXSmallTextStyle.copyWith(color: kGreenColor300),
            ),
          ),
        ],
      ),
    );
  }
}
