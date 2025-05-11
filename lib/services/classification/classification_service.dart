import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ClassificationService {
  final String? endpointUrl;
  static ClassificationService? _instance;

  factory ClassificationService({required String endpointUrl}) {
    if (_instance == null || _instance!.endpointUrl != endpointUrl) {
      _instance = ClassificationService._internal(endpointUrl: endpointUrl);
    }
    return _instance!;
  }
  ClassificationService._internal({required this.endpointUrl});

  Future<http.Response?> processClassification({
    required String base64Image,
  }) async {
    try {
      if (endpointUrl == null) {
        log("Error: endpointUrl is null");
        return null;
      }

      log("Sending request to: $endpointUrl");
      log("Image size: ${base64Image.length} characters");

      final body = await compute(_encodeBody, base64Image);

      final response = await http.post(
        Uri.parse(endpointUrl!),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      log("Response status code: ${response.statusCode}");
      if (response.statusCode != 200) {
        log("Error response body: ${response.body}");
      }

      return response;
    } catch (e) {
      log("Classification error: $e");
      return null;
    }
  }

  static String _encodeBody(String base64Image) {
    return jsonEncode({
      "image": base64Image,
    });
  }
}
