import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: BackgroundImage(
        imagePath: "assets/images/home_bg.jpg",
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text("Hello"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
