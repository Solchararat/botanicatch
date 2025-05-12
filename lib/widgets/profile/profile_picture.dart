import 'package:botanicatch/services/auth/auth_service.dart';
import 'package:botanicatch/services/storage/storage_service.dart';
import 'package:botanicatch/utils/constants.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';

class ProfilePicture extends StatefulWidget {
  final bool isEditable;
  final ValueNotifier<Uint8List?> profileImgBytes;
  final double width;
  final double height;
  const ProfilePicture(
      {super.key,
      required this.profileImgBytes,
      this.isEditable = false,
      this.width = 100,
      this.height = 100});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  static final String? _uid = AuthService.instance.currentUser?.uid;
  final StorageService _storage = StorageService.instance;
  final ImagePicker _picker = ImagePicker();
  final String _filePath = "users/$_uid/profile-picture/profile.jpg";

  @override
  void initState() {
    super.initState();
    _getProfilePicture();
  }

  Future<void> _onProfileTapped() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageBytes = await image.readAsBytes();
    widget.profileImgBytes.value = imageBytes;

    await _storage.uploadFile(_filePath, image);
    await _getProfilePicture();
  }

  Future<void> _getProfilePicture() async {
    try {
      final imageBytes = await _storage.getFile(_filePath);
      widget.profileImgBytes.value = imageBytes;
      if (imageBytes == null) return;
    } catch (e) {
      log("Profile picture not uploaded yet.");
    }
  }

  Widget _buildProfileContainer(
      {required bool isEditable, Uint8List? imageBytes}) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color:
            isEditable && imageBytes != null ? Colors.black : Colors.grey[300],
        border: isEditable ? null : Border.all(color: kGreenColor500, width: 3),
        shape: BoxShape.circle,
        image: imageBytes != null
            ? DecorationImage(
                image: Image.memory(imageBytes, fit: BoxFit.cover).image,
                fit: BoxFit.cover,
                opacity: isEditable ? 0.5 : 1.0,
              )
            : null,
      ),
      child: isEditable
          ? Center(
              child: Icon(
                Icons.camera_alt_outlined,
                color: imageBytes != null ? Colors.white : Colors.black38,
                size: 25,
              ),
            )
          : (imageBytes == null
              ? const Center(
                  child: Icon(
                    Icons.person_rounded,
                    color: Colors.black38,
                    size: 25,
                  ),
                )
              : null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.profileImgBytes,
      builder: (_, imageBytes, __) {
        final container = _buildProfileContainer(
          isEditable: widget.isEditable,
          imageBytes: imageBytes,
        );

        if (widget.isEditable) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () async {
                    await _onProfileTapped();
                  },
                  child: container),
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
                    ),
                    Text(
                      "Recommended: Square image, at least 400x400 pixels",
                      style: kXXSmallTextStyle.copyWith(
                        fontSize: 11,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return container;
      },
    );
  }
}
