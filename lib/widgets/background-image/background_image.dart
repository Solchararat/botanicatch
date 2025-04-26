import 'package:flutter/material.dart';
import 'package:botanicatch/utils/constants.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;
  final double? opacity;
  const BackgroundImage({super.key, required this.child, this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
          opacity: opacity ?? 1,
        ),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: kGreenColor400,
          width: 8,
        ),
      ),
      child: child,
    );
  }
}
