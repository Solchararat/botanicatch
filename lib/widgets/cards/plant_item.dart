import 'dart:typed_data';

import 'package:botanicatch/models/plant_model.dart';
import 'package:botanicatch/screens/home/plant_item_screen.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';

class PlantItem extends StatelessWidget {
  final ValueNotifier<Uint8List?> profileImgBytes;
  final PlantModel plant;
  final String? plantId;

  const PlantItem({
    super.key,
    required this.plant,
    required this.plantId,
    required this.profileImgBytes,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlantItemScreen(
              profileImgBytes: profileImgBytes,
              plant: plant,
            ),
          ),
        );
      },
      child: Container(
        width: 170,
        height: 150,
        decoration: BoxDecoration(
          gradient: const RadialGradient(
            colors: [kGreenColor100, kGreenColor500],
            radius: 0.8,
          ),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(plant.imageURL), fit: BoxFit.cover),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: const BoxDecoration(
              color: kGreenColor400,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8,
              children: [
                Text(
                  "#${plantId ?? ''}",
                  style: kXXSmallTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                  child: Text(
                    plant.commonName,
                    style: kXXSmallTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
