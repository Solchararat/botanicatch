import 'dart:developer';
import 'dart:typed_data';

import 'package:botanicatch/models/badge_model.dart';
import 'package:botanicatch/models/plant_model.dart';
import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/services/badges/badge_service.dart';
import 'package:botanicatch/services/db/db_service.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/modals/edit_profile_modal.dart';
import 'package:botanicatch/widgets/profile/achievement_badges.dart';
import 'package:botanicatch/widgets/cards/activity_item.dart';
import 'package:botanicatch/widgets/profile/profile_header.dart';
import 'package:botanicatch/widgets/profile/section_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final ValueNotifier<Uint8List?> profileImgBytes;

  const ProfileScreen({super.key, required this.profileImgBytes});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ValueNotifier<Uint8List?> _bannerImgBytes;
  late UserModel? _user;
  late Stream<List<QueryDocumentSnapshot>> _plantsStream;
  static final BadgeService _badgeService = BadgeService();

  @override
  void initState() {
    super.initState();
    _bannerImgBytes = ValueNotifier(null);
  }

  @override
  void dispose() {
    _bannerImgBytes.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = Provider.of<UserModel?>(context);
    if (_user != null && _user!.uid != null) {
      final databaseService = DatabaseService(uid: _user!.uid!);
      _plantsStream = databaseService.plantsStreamDescending;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _user == null || _user?.username == null || _user!.username!.isEmpty
        ? const BackgroundImage(
            imagePath: "assets/images/home-bg.jpg",
            child: Center(
              child: CircularProgressIndicator(
                color: kGreenColor300,
              ),
            ),
          )
        : Stack(
            children: [
              const BackgroundImage(
                imagePath: "assets/images/home-bg.jpg",
                hasPadding: false,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    ProfileHeader(
                      profileImgBytes: widget.profileImgBytes,
                      bannerImgBytes: _bannerImgBytes,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8,
                      children: [
                        // to make the name centered
                        const SizedBox(width: 16),
                        Text(
                          _user?.username ?? "null",
                          style: kSmallTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => EditProfileModal(
                                      profileImgBytes: widget.profileImgBytes,
                                      bannerImgBytes: _bannerImgBytes,
                                    ));
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
                    const ProfileSectionTitle(title: "Recent Catches"),
                    StreamBuilder<List<QueryDocumentSnapshot>>(
                      stream: _plantsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final plants = snapshot.data!
                              .take(3)
                              .map((doc) => PlantModel.fromJson(
                                  doc.data() as Map<String, dynamic>))
                              .toList();
                          return Column(
                            children: plants
                                .map((plant) => ActivityItem(plant: plant))
                                .toList(),
                          );
                        }
                        return const CircularProgressIndicator(
                            color: kGreenColor300);
                      },
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
            ],
          );
  }
}
