import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'dart:io';
import 'package:botanicatch/models/plant_model.dart';
import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/services/classification/classification_service.dart';
import 'package:botanicatch/services/db/db_service.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Future<String> _encodeImg(String filePath) async {
  final File file = File(filePath);
  final bytes = await file.readAsBytes();
  return base64Encode(bytes);
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeFuture;
  late ValueNotifier<bool> _isInitialized;
  late ValueNotifier<bool> _hasError;
  late ValueNotifier<XFile?> _capturedImage;
  static const String _endpointURL = "http://192.168.100.42:8000/classify";
  static final ClassificationService _classificationService =
      ClassificationService(endpointUrl: _endpointURL);
  late UserModel? _user;
  late ValueNotifier<bool> _isFlashOn;

  @override
  void initState() {
    super.initState();
    _isInitialized = ValueNotifier<bool>(false);
    _hasError = ValueNotifier<bool>(false);
    _isFlashOn = ValueNotifier<bool>(false);
    _capturedImage = ValueNotifier<XFile?>(null);
    _initializeFuture = _initializeCamera();
  }

  @override
  void didChangeDependencies() {
    _user = Provider.of<UserModel?>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    _capturedImage.dispose();
    _isInitialized.dispose();
    _hasError.dispose();
    _isFlashOn.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      final XFile picture = await _controller.takePicture();
      _capturedImage.value = picture;
      final String base64Image = await compute(_encodeImg, picture.path);
      final response = await _classificationService.processClassification(
          base64Image: base64Image);

      if (response != null && response.statusCode == 200) {
        final newData = jsonDecode(response.body);
        log("data: $newData");
        final plant = PlantModel.fromJson(newData);
        await DatabaseService(uid: _user!.uid!).addPlantData(plant);
      }
    } catch (e) {
      debugPrint('Error capturing image: $e');
    }
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw Exception('No cameras found on this device.');
      }

      final firstCamera = cameras.first;
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.max,
        enableAudio: false,
      );

      await _controller.initialize();

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
                final xScale = _controller.value.aspectRatio / deviceRatio;
                final double yScale = 1;
                return SafeArea(
                  bottom: false,
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: deviceRatio,
                        child: Transform(
                          alignment: Alignment.center,
                          transform:
                              Matrix4.diagonal3Values(xScale - 1, yScale, 1),
                          child: CameraPreview(_controller),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: ValueListenableBuilder(
                            valueListenable: _isFlashOn,
                            builder: (context, flash, _) {
                              return IconButton(
                                icon: Icon(
                                  flash ? Icons.flash_on : Icons.flash_off,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  try {
                                    await _controller.setFlashMode(flash
                                        ? FlashMode.off
                                        : FlashMode.torch);
                                    _isFlashOn.value = !_isFlashOn.value;
                                  } catch (e) {
                                    log("ERROR: $e");
                                  }
                                },
                              );
                            }),
                      ),
                      RepaintBoundary(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 1.5,
                                  sigmaY: 1.5,
                                  tileMode: TileMode.decal),
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
                                    InkWell(
                                      onTap: _takePicture,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 100),
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 16,
                                      child: ValueListenableBuilder<XFile?>(
                                        valueListenable: _capturedImage,
                                        builder: (context, image, _) {
                                          if (image == null) {
                                            return const SizedBox.shrink();
                                          }
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 100),
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
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
                      )
                    ],
                  ),
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
