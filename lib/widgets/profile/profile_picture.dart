import 'package:botanicatch/services/auth/auth_service.dart';
import 'package:botanicatch/services/storage/storage_service.dart';
import 'package:botanicatch/utils/constants.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';

class ProfilePicture extends StatefulWidget {
  final bool isEditable;
  const ProfilePicture({super.key, this.isEditable = false});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  static final String? _uid = AuthService.instance.currentUser?.uid;
  final StorageService _storage = StorageService.instance;
  final ImagePicker _picker = ImagePicker();
  final String _filePath = "users/$_uid/profile-picture/profile.jpg";
  late final ValueNotifier<Uint8List?> _imageNotifier;

  Future<void> _onProfileTapped() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageBytes = await image.readAsBytes();
    _imageNotifier.value = imageBytes;

    await _storage.uploadFile(_filePath, image);
  }

  Future<void> _getProfilePicture() async {
    try {
      final imageBytes = await _storage.getFile(_filePath);
      _imageNotifier.value = imageBytes;
      if (imageBytes == null) return;
    } catch (e) {
      log("Profile picture not uploaded yet.");
    }
  }

  @override
  void initState() {
    super.initState();
    _imageNotifier = ValueNotifier(null);
    _getProfilePicture();
  }

  @override
  void dispose() {
    _imageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isEditable
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: _onProfileTapped,
                child: ValueListenableBuilder(
                  valueListenable: _imageNotifier,
                  builder: (_, imageBytes, __) {
                    return Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: imageBytes != null
                            ? Colors.black
                            : Colors.grey[300],
                        shape: BoxShape.circle,
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
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: imageBytes != null
                              ? Colors.white
                              : Colors.black38,
                          size: 25,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Tap on the profile picture to change it",
                      style: kXXSmallTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      softWrap: true,
                    ),
                    Text(
                      "Recommended: Square image, at least 400x400 pixels",
                      style: kXXSmallTextStyle.copyWith(
                          fontSize: 11, color: Colors.grey[300]),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          )
        : ValueListenableBuilder(
            valueListenable: _imageNotifier,
            builder: (_, imageBytes, __) {
              return Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: kGreenColor500, width: 3),
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
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
                            Icons.person_rounded,
                            color: Colors.black38,
                            size: 25,
                          ),
                        )
                      : null);
            });
  }
}
