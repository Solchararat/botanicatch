import 'package:flutter/material.dart';

class PlantActionGrid extends StatelessWidget {
  final Widget topLeftWidget;
  final Widget topRightWidget;
  final Widget bottomLeftWidget;
  final Widget bottomRightWidget;
  const PlantActionGrid(
      {super.key,
      required this.topLeftWidget,
      required this.topRightWidget,
      required this.bottomLeftWidget,
      required this.bottomRightWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Row(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [topLeftWidget, topRightWidget],
        ),
        Row(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [bottomLeftWidget, bottomRightWidget],
        )
      ],
    );
  }
}
