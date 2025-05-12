import 'dart:typed_data';

import 'package:botanicatch/models/plant_model.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/utils/extensions.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/profile/profile_picture.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlantItemScreen extends StatelessWidget {
  final ValueNotifier<Uint8List?> profileImgBytes;
  final PlantModel plant;

  const PlantItemScreen({
    super.key,
    required this.plant,
    required this.profileImgBytes,
  });

  List<Widget> _formatPlantType() {
    return plant.type.map((type) {
      switch (type.toLowerCase()) {
        case "medicinal":
          return Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: medicinalType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        case "ornamental":
          return Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: ornamentalType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        case "edible":
          return Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: edibleType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        case "poisonous":
          return Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: poisonousType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        case "native":
          return Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: nativeType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        case "invasive":
          return Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: invasiveType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        case "tree":
          return Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: treeType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        case "herb/shrub":
          return Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: herbType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        case "aquatic":
          return Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: aquaticType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        case "climber/vine":
          return Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: climberType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        default:
          return Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: defaultType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        imagePath: "assets/images/home-bg.jpg",
        hasPadding: false,
        child: SafeArea(
          left: false,
          right: false,
          child: Column(
            spacing: 8,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    SvgPicture.asset(
                      "assets/images/botanicatch.svg",
                      height: 45,
                    ),
                    ProfilePicture(
                      profileImgBytes: profileImgBytes,
                      width: 50,
                      height: 50,
                    )
                  ],
                ),
              ),
              CachedNetworkImage(
                imageUrl: plant.imageURL,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(color: kGreenColor300),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: kGreenColor500,
                ),
              )
            ],
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
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Text("Type:",
                        style: kSmallTextStyle.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Row(
                      spacing: 8,
                      children: _formatPlantType(),
                    )
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
