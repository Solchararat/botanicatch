import 'dart:typed_data';
import 'dart:developer';
import 'package:botanicatch/services/auth/auth_service.dart';
import 'package:botanicatch/services/storage/storage_service.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileBanner extends StatefulWidget {
  final bool isEditable;
  final ValueNotifier<Uint8List?> bannerImgBytes;

  const ProfileBanner(
      {super.key, required this.bannerImgBytes, this.isEditable = false});

  @override
  State<ProfileBanner> createState() => _ProfileBannerState();
}

class _ProfileBannerState extends State<ProfileBanner> {
  static final String? _uid = AuthService.instance.currentUser?.uid;
  final StorageService _storage = StorageService.instance;
  final ImagePicker _picker = ImagePicker();
  final String _filePath = "users/$_uid/banner-picture/banner.jpg";

  @override
  void initState() {
    super.initState();
    _getBannerPicture();
  }

  Future<void> _onBannerTapped() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageBytes = await image.readAsBytes();
    widget.bannerImgBytes.value = imageBytes;

    await _storage.uploadFile(_filePath, image);
  }

  Future<void> _getBannerPicture() async {
    try {
      final imageBytes = await _storage.getFile(_filePath);
      widget.bannerImgBytes.value = imageBytes;
      if (imageBytes == null) return;
    } catch (e) {
      log("Banner picture not uploaded yet.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isEditable
        ? Stack(
            children: [
              GestureDetector(
                onTap: _onBannerTapped,
                child: ValueListenableBuilder(
                    valueListenable: widget.bannerImgBytes,
                    builder: (_, imageBytes, __) {
                      return Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: imageBytes != null
                              ? Colors.black
                              : Colors.grey[300],
                          image: imageBytes != null
                              ? DecorationImage(
                                  opacity: .5,
                                  image: Image.memory(
                                    imageBytes,
                                    fit: BoxFit.cover,
                                  ).image,
                                  fit: BoxFit.cover)
                              : null,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: imageBytes != null
                                    ? Colors.white
                                    : Colors.black38,
                                size: 30,
                              ),
                              Text(
                                "Tap to change banner image",
                                style: kXXSmallTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: imageBytes != null
                                        ? Colors.white
                                        : Colors.black38),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          )
        : ValueListenableBuilder(
            valueListenable: widget.bannerImgBytes,
            builder: (_, imageBytes, __) {
              return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    image: imageBytes != null
                        ? DecorationImage(
                            image: Image.memory(
                              imageBytes,
                              fit: BoxFit.cover,
                            ).image,
                            fit: BoxFit.cover)
                        : null,
                  ),
                  child: imageBytes == null
                      ? const Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.black38,
                            size: 30,
                          ),
                        )
                      : null);
            });
  }
}
