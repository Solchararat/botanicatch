import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';

class StorageService {
  StorageService._internal();
  static StorageService? _instance;
  static StorageService get instance =>
      _instance ??= StorageService._internal();
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  final Map<String, Uint8List> _cache = {};

  Future<void> uploadFile(String fileName, XFile file) async {
    try {
      final imageRef = _storage.ref(fileName);
      final imageBytes = await file.readAsBytes();
      await imageRef.putData(imageBytes);
      _cache[fileName] = imageBytes;
    } catch (e) {
      log("Could not upload file.");
    }
  }

  Future<Uint8List?> getFile(String fileName) async {
    if (_cache.containsKey(fileName)) return _cache[fileName];

    try {
      final imageRef = _storage.ref(fileName);
      final data = await imageRef.getData();
      if (data != null) _cache[fileName] = data;
      return data;
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') return null;
      log("Unexpected storage error: $e");
      return null;
    }
  }
}
