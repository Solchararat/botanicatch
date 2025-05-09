import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
      controller = CameraController(firstCamera, ResolutionPreset.max);

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
    return FutureBuilder<void>(
      future: _initializeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (_hasError.value) {
            return const BackgroundImage(
              imagePath: "assets/images/home-bg.jpg",
              child: Center(
                child: Text('Failed to initialize camera.'),
              ),
            );
          }

          if (_isInitialized.value) {
            return CameraPreview(controller);
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
    );
  }
}
