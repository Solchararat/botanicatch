import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:flutter/material.dart';

class GardenScreen extends StatelessWidget {
  const GardenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackgroundImage(imagePath: "assets/images/home_bg.jpg");
  }
}
