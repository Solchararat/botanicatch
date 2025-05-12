import 'dart:typed_data';

import 'package:botanicatch/models/plant_model.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/utils/extensions.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/profile/profile_picture.dart';
import 'package:flutter/material.dart';

class PlantItemScreen extends StatelessWidget {
  final ValueNotifier<Uint8List?> profileImgBytes;
  final PlantModel plant;

  const PlantItemScreen({
    super.key,
    required this.plant,
    required this.profileImgBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        imagePath: "assets/images/home-bg.jpg",
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    Image.asset("assets/images/logo-small.png", height: 45),
                    ProfilePicture(
                      profileImgBytes: profileImgBytes,
                      width: 50,
                      height: 50,
                    )
                  ],
                ),
                Image.asset("assets/images/new-plants.png"),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) => SizedBox(
          height: 350,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plant.commonName,
                    style: kSmallTextStyle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                Text(plant.scientificName,
                    style: kXXSmallTextStyle.copyWith(
                        color: Colors.black, fontStyle: FontStyle.italic)),
                const SizedBox(height: 16),
                Text("Description",
                    style: kSmallTextStyle.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                Text(plant.description,
                    style: kXXSmallTextStyle.copyWith(color: kGrayColor400)),
                const SizedBox(height: 16),
                Row(
                  spacing: 16,
                  children: [
                    Text("Type:",
                        style: kSmallTextStyle.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Text(plant.type.map((t) => t.capitalize()).join(',\n'),
                        style: kSmallTextStyle.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
