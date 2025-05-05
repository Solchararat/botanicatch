import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';

class PlantItem extends StatelessWidget {
  final String? plantId;
  final String? commonName;
  final String? scientificName;
  final String? description;
  final String? type;
  const PlantItem({
    super.key,
    this.plantId,
    this.commonName,
    this.scientificName,
    this.description,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: 170,
          height: 150,
          decoration: BoxDecoration(
            gradient: const RadialGradient(
              colors: [
                kGreenColor100,
                kGreenColor500,
              ],
              radius: 0.8,
            ),
            borderRadius: BorderRadius.circular(20),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("#$plantId", style: kXXSmallTextStyle),
                    Text("$commonName", style: kXXSmallTextStyle),
                  ],
                )),
          )),
    );
  }
}
