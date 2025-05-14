import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraDock extends StatelessWidget {
  final ValueNotifier<bool> isLoading;
  final ValueNotifier<XFile?> capturedImage;
  final VoidCallback onTakePicture;

  const CameraDock(
      {super.key,
      required this.isLoading,
      required this.capturedImage,
      required this.onTakePicture});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 1.5, sigmaY: 1.5, tileMode: TileMode.decal),
            child: Container(
              height: 230,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: isLoading,
                    builder: (_, isLoading, __) {
                      return InkWell(
                        onTap: isLoading ? null : onTakePicture,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 100),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.transparent,
                            border: Border.all(
                              color: isLoading ? Colors.grey : Colors.white,
                              width: 5,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 16,
                    child: ValueListenableBuilder<XFile?>(
                      valueListenable: capturedImage,
                      builder: (context, image, _) {
                        if (image == null) {
                          return const SizedBox.shrink();
                        }
                        return Container(
                          margin: const EdgeInsets.only(bottom: 100),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: ClipOval(
                            child: Image.file(
                              File(image.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
