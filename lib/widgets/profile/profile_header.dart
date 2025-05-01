import 'package:botanicatch/widgets/profile/profile_picture.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      // Banner Image
      // Photo by <a href="https://unsplash.com/@vladutremus?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Vladut Tomsa</a> on <a href="https://unsplash.com/photos/green-trees-on-green-grass-field-under-blue-sky-during-daytime-HrsJTdMqfvg?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
      // TODO: Implement banner uploading if required.
      children: [
        Image.asset("assets/images/banner.jpg",
            width: MediaQuery.of(context).size.width * 1,
            height: 200,
            fit: BoxFit.cover),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(height: 140),
              const ProfilePicture(),
            ],
          ),
        ),
      ],
    );
  }
}
