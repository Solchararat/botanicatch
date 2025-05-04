import 'dart:typed_data';

import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/cards/plant_item.dart';
import 'package:botanicatch/widgets/profile/profile_picture.dart';
import 'package:flutter/material.dart';

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  late final ValueNotifier<Uint8List?> _profileImgBytes;

  @override
  void initState() {
    super.initState();
    _profileImgBytes = ValueNotifier<Uint8List?>(null);
  }

  @override
  void dispose() {
    _profileImgBytes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      imagePath: "assets/images/home_bg.jpg",
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 45),
                  Image.asset(
                    "assets/images/logo-small.png",
                    cacheWidth: 190,
                    cacheHeight: 100,
                  ),
                  ProfilePicture(
                    profileImgBytes: _profileImgBytes,
                    width: 50,
                    height: 50,
                  )
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: kGreenColor300,
                  ),
                  hintText: "Search Plant",
                  contentPadding: const EdgeInsets.all(12),
                  hintStyle: kXXSmallTextStyle.copyWith(color: kGreenColor300),
                  border: kGardenOutlineInputBorder,
                  enabledBorder: kGardenOutlineInputBorder,
                  focusedBorder: kGardenOutlineInputBorder,
                  errorBorder: kGardenOutlineInputBorder,
                  focusedErrorBorder: kGardenOutlineInputBorder,
                ),
              ),
              const PlantItem(),
            ],
          ),
        ),
      ),
    );
  }
}
