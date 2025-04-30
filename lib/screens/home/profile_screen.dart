import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/profile-picture/profile_picture.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackgroundImage(
            imagePath: "assets/images/home_bg.jpg",
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    // accounts the size of the banner
                    const SizedBox(height: 190),
                    Text("Uncle Kevin", style: kSmallTextStyle),
                  ],
                ),
              ),
            ),
          ),
          // Photo by <a href="https://unsplash.com/@vladutremus?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Vladut Tomsa</a> on <a href="https://unsplash.com/photos/green-trees-on-green-grass-field-under-blue-sky-during-daytime-HrsJTdMqfvg?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
          // TODO: Implement banner uploading if required.
          Image.asset(
            "assets/images/banner.jpg",
            width: MediaQuery.of(context).size.width * 1,
            height: 200,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const SizedBox(height: 140),
                const ProfilePicture(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
