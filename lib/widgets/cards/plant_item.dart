import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';

class PlantItem extends StatelessWidget {
  final String? name;
  final String? number;
  const PlantItem({super.key, this.name, this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              width: 170,
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
                  Text("#$number", style: kXXSmallTextStyle),
                  Text("$name", style: kXXSmallTextStyle),
                ],
              )),
        ));
  }
}
