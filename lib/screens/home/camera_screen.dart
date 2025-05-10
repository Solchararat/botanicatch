import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late Future<void> _initializeFuture;
  late ValueNotifier<bool> _isInitialized;
  late ValueNotifier<bool> _hasError;

  @override
  void initState() {
    super.initState();
    _isInitialized = ValueNotifier<bool>(false);
    _hasError = ValueNotifier<bool>(false);
    _initializeFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw Exception('No cameras found on this device.');
      }

      final firstCamera = cameras.first;
      controller = CameraController(
        firstCamera,
        ResolutionPreset.max,
        enableAudio: false,
      );

      await controller.initialize();

      if (!mounted) return;

      _isInitialized.value = true;
    } catch (e) {
      if (e is CameraException && e.code == 'CameraAccessDenied') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Camera access denied.')),
        );
      } else {
        debugPrint('Camera initialization error: $e');
      }

      if (!mounted) return;

      _hasError.value = true;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Expanded(
            child: BackgroundImage(imagePath: "assets/images/home-bg.jpg")),
        FutureBuilder<void>(
          future: _initializeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (_hasError.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Please allow permissions to use the camera.',
                        style: kXXSmallTextStyle,
                      ),
                      TextButton(
                          onPressed: () => openAppSettings(),
                          child: Text(
                            "Open app settings",
                            style: kXXSmallTextStyle.copyWith(
                                color: kGreenColor300),
                          ))
                    ],
                  ),
                );
              }

              if (_isInitialized.value) {
                final size = MediaQuery.of(context).size;
                final deviceRatio = size.width / size.height;
                final xScale = controller.value.aspectRatio / deviceRatio;
                final double yScale = 1;
                return Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: deviceRatio,
                      child: Transform(
                        alignment: Alignment.center,
                        transform:
                            Matrix4.diagonal3Values(xScale - 1, yScale, 1),
                        child: CameraPreview(controller),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 120),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                    border: const Border(
                                      top: BorderSide(
                                          color: kGrayColor300, width: 5),
                                      bottom: BorderSide(
                                          color: kGrayColor300, width: 5),
                                      left: BorderSide(
                                          color: kGrayColor300, width: 5),
                                      right: BorderSide(
                                          color: kGrayColor300, width: 5),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }

              return const Center(
                child: Text('Camera not initialized.'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: kGreenColor300,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
