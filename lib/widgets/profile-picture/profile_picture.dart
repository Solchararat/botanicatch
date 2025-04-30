import 'package:botanicatch/services/auth/auth_service.dart';
import 'package:botanicatch/services/storage/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

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
    return GestureDetector(
      onTap: _onProfileTapped,
      child: ValueListenableBuilder(
          valueListenable: _imageNotifier,
          builder: (_, imageBytes, __) {
            return Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                image: imageBytes != null
                    ? DecorationImage(
                        // cacheHeight and cacheWidth match the Container's dimensions
                        image: Image.memory(
                          imageBytes,
                          fit: BoxFit.cover,
                        ).image,
                        fit: BoxFit.cover)
                    : null,
              ),
              child: const Center(
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.black38,
                  size: 25,
                ),
              ),
            );
          }),
    );
  }
}
