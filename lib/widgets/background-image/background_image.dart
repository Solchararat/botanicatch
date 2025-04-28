import 'package:flutter/material.dart';
import 'package:botanicatch/utils/constants.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;
  final double? opacity;
  final String imagePath;
  const BackgroundImage({
    super.key,
    required this.child,
    required this.imagePath,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          opacity: opacity ?? 1,
        ),
      ),
      child: child,
    );
  }
}
