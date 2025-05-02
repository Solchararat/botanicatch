import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class StorageService {
  StorageService._internal();
  static StorageService? _instance;
  static StorageService get instance =>
      _instance ??= StorageService._internal();
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  final Map<String, Uint8List> _cache = {};

  Future<void> _saveToLocal(String fileName, Uint8List bytes) async {
    try {
      final dir = await getApplicationDocumentsDirectory();

      final filePath = p.join(dir.path, fileName);
      final parentDir = Directory(p.dirname(filePath));
      await parentDir.create(recursive: true);

      final file = File(filePath);
      await file.writeAsBytes(bytes);
    } catch (e) {
      log("Failed to save locally: $e");
    }
  }

  Future<Uint8List?> _readFromLocal(String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = p.join(dir.path, fileName);
      final parentDir = Directory(p.dirname(filePath));
      await parentDir.create(recursive: true);

      final file = File(filePath);
      if (await file.exists()) {
        return await file.readAsBytes();
      }
    } catch (e) {
      log("Local read error: $e");
    }
    return null;
  }

  Future<void> uploadFile(String fileName, XFile file) async {
    try {
      final imageBytes = await file.readAsBytes();
      await _storage.ref(fileName).putData(imageBytes);
      _cache[fileName] = imageBytes;
      await _saveToLocal(fileName, imageBytes);
    } catch (e) {
      log("Could not upload file.");
    }
  }

  Future<Uint8List?> getFile(String fileName) async {
    if (_cache.containsKey(fileName)) return _cache[fileName];

    final localBytes = await _readFromLocal(fileName);

    if (localBytes != null) {
      _cache[fileName] = localBytes;
      return localBytes;
    }

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
