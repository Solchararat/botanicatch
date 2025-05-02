import 'dart:typed_data';

import 'package:botanicatch/widgets/profile/profile_banner.dart';
import 'package:botanicatch/widgets/profile/profile_picture.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final ValueNotifier<Uint8List?> profileImgBytes;
  final ValueNotifier<Uint8List?> bannerImgBytes;

  const ProfileHeader(
      {super.key, required this.profileImgBytes, required this.bannerImgBytes});

  @override
  Widget build(BuildContext context) {
    return Stack(
      // Banner Image
      // Photo by <a href="https://unsplash.com/@vladutremus?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Vladut Tomsa</a> on <a href="https://unsplash.com/photos/green-trees-on-green-grass-field-under-blue-sky-during-daytime-HrsJTdMqfvg?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
      // TODO: Implement banner uploading if required.
      children: [
        ProfileBanner(
          bannerImgBytes: bannerImgBytes,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(height: 140),
              ProfilePicture(
                profileImgBytes: profileImgBytes,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
