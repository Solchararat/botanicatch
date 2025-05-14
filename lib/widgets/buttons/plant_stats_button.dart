import 'package:botanicatch/services/db/db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlantStatsButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  final String heading;
  final String subheading;
  final double right;
  final double bottom;
  final int cacheWidth;
  final int cacheHeight;
  final bool useDynamicSubheading;
  final String dynamicSubheadingTemplate;

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
    this.useDynamicSubheading = false,
    this.dynamicSubheadingTemplate = "",
  });

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

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
                if (useDynamicSubheading && uid != null)
                  StreamBuilder<List<QueryDocumentSnapshot>>(
                    stream: DatabaseService(uid: uid).plantsStreamAscending,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "Loading...",
                          style: kXXSmallTextStyle,
                        );
                      }
                      if (snapshot.hasError) {
                        return const Text("Error", style: kXXSmallTextStyle);
                      }
                      int count = snapshot.data?.length ?? 0;
                      return Text(
                        dynamicSubheadingTemplate.replaceAll(
                            "{count}", count.toString()),
                        style: kXXSmallTextStyle.copyWith(
                            color: kGrayColor400, fontWeight: FontWeight.bold),
                      );
                    },
                  )
                else
                  Text(
                    subheading,
                    style: kXXSmallTextStyle.copyWith(
                        color: kGrayColor400, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
          Positioned(
            right: right,
            bottom: bottom,
            child: SvgPicture.asset(
              imagePath,
              width: cacheWidth.toDouble(),
              height: cacheHeight.toDouble(),
            ),
          ),
        ],
      ),
    );
  }
}
