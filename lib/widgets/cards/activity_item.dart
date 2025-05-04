import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: 280,
      height: 80,
      decoration: BoxDecoration(
        color: kGrayColor100,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
