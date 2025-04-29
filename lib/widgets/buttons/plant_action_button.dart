import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';

class PlantActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  final String title;
  final Color radialColor;
  final Color mainColor;
  final double right;
  final double top;
  final int cacheWidth;
  final int cacheHeight;
  const PlantActionButton({
    super.key,
    required this.onTap,
    required this.imagePath,
    required this.title,
    required this.mainColor,
    required this.radialColor,
    required this.right,
    required this.top,
    required this.cacheWidth,
    required this.cacheHeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width * .40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 3,
                colors: [
                  radialColor,
                  mainColor,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(title,
                    style: kXXSmallTextStyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
          ),
          Positioned(
            right: right,
            top: top,
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
