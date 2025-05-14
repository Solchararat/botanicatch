import 'dart:developer';

import 'package:botanicatch/models/plant_model.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ActivityItem extends StatelessWidget {
  final PlantModel? plant;
  const ActivityItem({super.key, this.plant});

  List<Widget> _formatPlantType({double width = 65, double padding = 2}) {
    return plant!.type.map((type) {
      switch (type.toLowerCase()) {
        case "medicinal":
          return Container(
            width: width,
            padding: EdgeInsets.all(padding),
            decoration: medicinalType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
        case "ornamental":
          return Container(
            width: width,
            padding: EdgeInsets.all(padding),
            decoration: ornamentalType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
        case "edible":
          return Container(
            width: width,
            padding: EdgeInsets.all(padding),
            decoration: edibleType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
        case "poisonous":
          return Container(
            width: width,
            padding: EdgeInsets.all(padding),
            decoration: poisonousType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
        case "native":
          return Container(
            width: width,
            padding: EdgeInsets.all(padding),
            decoration: nativeType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
        case "invasive":
          return Container(
            width: width,
            padding: EdgeInsets.all(padding),
            decoration: invasiveType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
        case "tree":
          return Container(
            width: width,
            padding: EdgeInsets.all(padding),
            decoration: treeType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
        case "herb/shrub":
          return Container(
            width: width,
            padding: EdgeInsets.all(padding),
            decoration: herbType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
        case "aquatic":
          return Container(
            width: width,
            padding: EdgeInsets.all(padding),
            decoration: aquaticType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
        case "climber/vine":
          return Container(
            width: width,
            padding: EdgeInsets.all(padding),
            decoration: climberType,
            child: Text(
              "Vine",
              style: kXXSmallTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
        default:
          return Container(
            width: 100,
            padding: EdgeInsets.all(padding),
            decoration: defaultType,
            child: Text(
              type.capitalize(),
              style: kXXSmallTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    log("deviceWidth: $deviceWidth");

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: deviceWidth * .8,
      height: 170,
      decoration: BoxDecoration(
          color: const Color(0xFF166534),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF15803D))),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0)),
            child: CachedNetworkImage(
              imageUrl: plant!.imageURL,
              height: double.infinity,
              width: deviceWidth > 600 ? 150 : 110,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const CircularProgressIndicator(color: kGreenColor200),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant!.commonName,
                    style: kSmallTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    plant!.scientificName,
                    style: kXXSmallTextStyle.copyWith(
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF86EFAC)),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: deviceWidth > 600
                        ? _formatPlantType(width: 80, padding: 4)
                        : _formatPlantType(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
