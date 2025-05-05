import 'dart:typed_data';

import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/utils/extensions.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/profile/profile_picture.dart';
import 'package:flutter/material.dart';

class PlantItemScreen extends StatelessWidget {
  final ValueNotifier<Uint8List?> profileImgBytes;
  final String? plantId;
  final String? commonName;
  final String? scientificName;
  final String? description;
  final String? type;
  const PlantItemScreen({
    super.key,
    this.plantId,
    this.commonName,
    this.scientificName,
    this.description,
    this.type,
    required this.profileImgBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        imagePath: "assets/images/home_bg.jpg",
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white)),
                    Image.asset(
                      "assets/images/logo-small.png",
                      height: 45,
                      fit: BoxFit.contain,
                    ),
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
          builder: (context) {
            return SizedBox(
              width: double.infinity,
              height: 350,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 18,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            commonName!,
                            textAlign: TextAlign.left,
                            style: kSmallTextStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            scientificName!,
                            style: kXXSmallTextStyle.copyWith(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                    Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            textAlign: TextAlign.left,
                            style: kSmallTextStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            description!,
                            style: kXXSmallTextStyle.copyWith(
                              color: kGrayColor400,
                            ),
                          ),
                        ]),
                    Row(
                      spacing: 16,
                      children: [
                        Text(
                          "Type:",
                          textAlign: TextAlign.left,
                          style: kSmallTextStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          type!.capitalize(),
                          style: kSmallTextStyle.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
