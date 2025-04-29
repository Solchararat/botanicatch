import 'package:flutter/material.dart';
import 'package:botanicatch/utils/constants.dart';

class CameraFab extends StatelessWidget {
  final VoidCallback onPressed;
  const CameraFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50),
          height: 64,
          width: 64,
          child: FloatingActionButton(
            onPressed: onPressed,
            elevation: 0,
            backgroundColor: kGreenColor300,
            shape: RoundedRectangleBorder(
                side: const BorderSide(width: 10, color: kGreenColor500),
                borderRadius: BorderRadius.circular(100)),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
            ),
          ),
        ),
        Text('Catch',
            style:
                kXXSmallTextStyle.copyWith(fontSize: 11, color: kGrayColor250)),
      ],
    );
  }
}
