import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';

class PlantStatsButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  final String heading;
  final String subheading;
  final double right;
  final double bottom;
  final int cacheWidth;
  final int cacheHeight;
  const PlantStatsButton({
    super.key,
    required this.onTap,
    required this.imagePath,
    required this.heading,
    required this.subheading,
    required this.right,
    required this.bottom,
    required this.cacheWidth,
    required this.cacheHeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * .4,
            height: 170,
            decoration: BoxDecoration(
              color: kGreenColor100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: kSmallTextStyle.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  subheading,
                  style: kXXSmallTextStyle.copyWith(
                      color: kGrayColor400, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Positioned(
            right: right,
            bottom: bottom,
            child: Image.asset(
              imagePath,
              cacheWidth: cacheWidth,
              cacheHeight: cacheHeight,
            ),
          ),
        ],
      ),
    );
  }
}
