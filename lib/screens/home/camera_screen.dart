import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:botanicatch/models/badge_model.dart';
import 'package:botanicatch/models/plant_model.dart';
import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/screens/home/plant_item_screen.dart';
import 'package:botanicatch/services/auth/auth_service.dart';
import 'package:botanicatch/services/badges/badge_service.dart';
import 'package:botanicatch/services/classification/classification_service.dart';
import 'package:botanicatch/services/db/db_service.dart';
import 'package:botanicatch/services/storage/storage_service.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/camera/camera_dock.dart';
import 'package:botanicatch/widgets/progress-indicators/botanicatch_loading.dart';
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
  final ValueNotifier<Uint8List?> profileImgBytes;
  const CameraScreen({super.key, required this.profileImgBytes});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeFuture;
  late ValueNotifier<bool> _isInitialized;
  late ValueNotifier<bool> _hasError;
  late ValueNotifier<XFile?> _capturedImage;
  late ValueNotifier<bool> _isFlashOn;
  late ValueNotifier<bool> _isLoading;
  late ValueNotifier<String> _loadingMessage;

  static const String _endpointURL = "http://192.168.100.42:8080/classify";
  static final ClassificationService _classificationService =
      ClassificationService(endpointUrl: _endpointURL);
  static final StorageService _storageService = StorageService.instance;
  static final String? _uid = AuthService.instance.currentUser?.uid;
  static final DatabaseService _databaseService = DatabaseService(uid: _uid!);
  static final BadgeService _badgeService = BadgeService();

  @override
  void initState() {
    super.initState();
    _initializeFuture = _initializeCamera();
    _isInitialized = ValueNotifier<bool>(false);
    _hasError = ValueNotifier<bool>(false);
    _isFlashOn = ValueNotifier<bool>(false);
    _loadingMessage = ValueNotifier<String>("Identifying plant species...");

    _isLoading = ValueNotifier<bool>(false);

    _capturedImage = ValueNotifier<XFile?>(null);
  }

  @override
  void dispose() {
    _controller.dispose();
    _capturedImage.dispose();
    _isInitialized.dispose();
    _hasError.dispose();
    _isFlashOn.dispose();
    _isLoading.dispose();
    _loadingMessage.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      _isLoading.value = true;
      _loadingMessage.value = "Capturing image...";

      final XFile picture = await _controller.takePicture();
      _capturedImage.value = picture;

      await _processImage(picture);
    } catch (e) {
      log('Error capturing image: $e');
    }
  }

  Future<void> _processImage(XFile picture) async {
    if (!mounted) return;
    _loadingMessage.value = "Processing image...";
    final String base64Image = await compute(_encodeImg, picture.path);

    if (!mounted) return;
    _loadingMessage.value = "Identifying plant species...";
    final response = await _classificationService.processClassification(
        base64Image: base64Image);

    if (response != null && response.statusCode == 200) {
      _loadingMessage.value = "Classification complete! Preparing data...";
      final newData = jsonDecode(response.body);
      final plant = PlantModel.fromJson(newData);

      if (plant.commonName.isEmpty || plant.scientificName.isEmpty) {
        throw Exception("ERROR: Gemini returned an invalid JSON format");
      }

      if (!mounted) return;
      _loadingMessage.value = "Uploading image...";
      final String imagePath =
          "users/${_uid!}/plants/${plant.plantId}-${plant.scientificName}.jpg";

      await _storageService.uploadFile(imagePath, picture);

      if (!mounted) return;
      _loadingMessage.value = "Finalizing...";
      final String imageUrl = await _storageService.getDownloadURL(imagePath);
      plant.imageURL = imageUrl;
      await _databaseService.addPlantData(plant);

      if (!mounted) return;
      _loadingMessage.value = "Checking achievements...";

      final UserModel? currentUser =
          Provider.of<UserModel?>(context, listen: false);

      if (currentUser != null) {
        final List<BadgeModel> newBadges =
            await _badgeService.checkAndUpdateBadges(currentUser, plant);
        if (mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlantItemScreen(
                        plant: plant,
                        profileImgBytes: widget.profileImgBytes,
                      )));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            for (final badge in newBadges) {
              _badgeService.showBadgeEarnedDialog(context, badge);
            }
          });
        }
      }

      if (!mounted) return;
      _isLoading.value = false;
    } else {
      _loadingMessage.value = "Error processing image. Please try again.";
      await Future.delayed(const Duration(seconds: 2));
      _isLoading.value = false;
    }
  }

  Future<void> _initializeCamera() async {
    try {
      log('Starting camera initialization');

      log('Requesting available cameras');
      final cameras = await availableCameras();
      log('Found ${cameras.length} cameras');

      if (cameras.isEmpty) {
        log('No cameras found on device');
        throw Exception('No cameras found on this device.');
      }

      final firstCamera = cameras.first;
      log('Setting up controller for camera: ${firstCamera.name}');

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.max,
        enableAudio: false,
      );

      log('Initializing camera controller');
      await _controller.initialize();
      log('Camera controller initialized successfully');

      if (!mounted) return;
      _isInitialized.value = true;
    } catch (e) {
      log('Camera initialization error: $e');
      if (!mounted) return;
      _hasError.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: BackgroundImage(imagePath: "assets/images/home-bg.jpg")),
        FutureBuilder<void>(
          future: _initializeFuture,
          builder: (context, snapshot) {
            log('FutureBuilder state: ${snapshot.connectionState}');
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
                              Matrix4.diagonal3Values(xScale - 1.5, yScale, 1),
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
                      CameraDock(
                          isLoading: _isLoading,
                          capturedImage: _capturedImage,
                          onTakePicture: _takePicture),
                      ValueListenableBuilder<bool>(
                        valueListenable: _isLoading,
                        builder: (_, isLoading, __) => isLoading
                            ? ValueListenableBuilder<String>(
                                valueListenable: _loadingMessage,
                                builder: (context, message, _) {
                                  return BotanicatchLoading(
                                    initialMessage: message,
                                  );
                                },
                              )
                            : const SizedBox.shrink(),
                      ),
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
