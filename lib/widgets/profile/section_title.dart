import 'package:flutter/material.dart';
import 'package:botanicatch/utils/constants.dart';

class ProfileSectionTitle extends StatelessWidget {
  final String title;
  const ProfileSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: kSmallTextStyle.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
