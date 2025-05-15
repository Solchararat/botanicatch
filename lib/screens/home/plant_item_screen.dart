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

  Widget _buildPlantTypeTag(String type) {
    final Map<String, BoxDecoration> typeDecorations = {
      "medicinal": medicinalType,
      "ornamental": ornamentalType,
      "edible": edibleType,
      "poisonous": poisonousType,
      "native": nativeType,
      "invasive": invasiveType,
      "tree": treeType,
      "herb/shrub": herbType,
      "aquatic": aquaticType,
      "climber/vine": climberType,
    };

    final String displayText =
        type.toLowerCase() == "climber/vine" ? "Vine" : type.capitalize();

    return Container(
      constraints: const BoxConstraints(minWidth: 80),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: typeDecorations[type.toLowerCase()] ?? defaultType,
      child: Text(
        displayText,
        style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  List<Widget> _formatPlantType() {
    return plant.type.map((type) => _buildPlantTypeTag(type)).toList();
  }

  Widget _buildPlantImage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: plant.imageURL,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(color: kGreenColor300)),
          errorWidget: (context, url, error) => const Center(
            child: Icon(
              Icons.error,
              color: kGreenColor500,
              size: 64,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      body: BackgroundImage(
        imagePath: "assets/images/home-bg.jpg",
        hasPadding: false,
        child: SafeArea(
          left: false,
          right: false,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
              isLandscape ? const SizedBox.shrink() : _buildPlantImage()
            ],
          ),
        ),
      ),
      bottomSheet: DraggableScrollableSheet(
        initialChildSize: isLandscape ? 0.9 : 0.4,
        minChildSize: isLandscape ? 0.5 : 0.2,
        maxChildSize: isLandscape ? 0.9 : 0.8,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: isLandscape
                ? _buildLandscapeLayout(scrollController)
                : _buildPortraitLayout(scrollController),
          );
        },
      ),
    );
  }

  Widget _buildPortraitLayout(ScrollController scrollController) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(bottom: 16),
          ),
        ),
        Text(
          plant.commonName,
          style: kSmallTextStyle.copyWith(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          plant.scientificName,
          style: kXXSmallTextStyle.copyWith(
              color: Colors.black, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        Text(
          "Description",
          style: kSmallTextStyle.copyWith(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          plant.description,
          style: kXXSmallTextStyle.copyWith(color: kGrayColor400),
        ),
        const SizedBox(height: 16),
        Text(
          "Type:",
          style: kSmallTextStyle.copyWith(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _formatPlantType(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildLandscapeLayout(ScrollController scrollController) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: plant.imageURL,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: kGreenColor300)),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.error,
                    color: kGreenColor500,
                    size: 64,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                ),
              ),
              Text(
                plant.commonName,
                style: kSmallTextStyle.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                plant.scientificName,
                style: kXXSmallTextStyle.copyWith(
                    color: Colors.black, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              Text(
                "Description",
                style: kSmallTextStyle.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                plant.description,
                style: kXXSmallTextStyle.copyWith(color: kGrayColor400),
              ),
              const SizedBox(height: 16),
              Text(
                "Type:",
                style: kSmallTextStyle.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _formatPlantType(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
